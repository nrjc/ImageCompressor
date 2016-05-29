function [vlc bits huffval] = lbtenc(X, qstep, N, M, opthuff, dcbits)
    
% JPEGENC Encode an image to a (simplified) LBT bit stream
%
%  [vlc bits huffval] = jpegenc(X, qstep, N, M, opthuff, dcbits) Encodes the
%  image in X to generate the variable length bit stream in vlc.
%
%  X is the input greyscale image
%  qstep is the quantisation step to use in encoding
%  N is the width of the DCT block (defaults to 8)
%  M is the width of each block to be coded (defaults to N). Must be an
%  integer multiple of N - if it is larger, individual blocks are
%  regrouped.
%  if opthuff is true (defaults to false), the Huffman table is optimised
%  based on the data in X
%  dcbits determines how many bits are used to encode the DC coefficients
%  of the DCT (defaults to 8)
%
%  vlc is the variable length output code, where vlc(:,1) are the codes, and
%  vlc(:,2) the number of corresponding valid bits, so that sum(vlc(:,2))
%  gives the total number of bits in the image
%  bits and huffval are optional outputs which return the Huffman encoding
%  used in compression

% This is global to avoid too much copying when updated by huffenc
global huffhist  % Histogram of usage of Huffman codewords.

% Presume some default values if they have not been provided
error(nargchk(2, 6, nargin, 'struct'));
if ((nargout~=1) && (nargout~=3)) error('Must have one or three output arguments'); end
if (nargin<6)
  dcbits = 8;
  if (nargin<5)
    opthuff = false;
    if (nargin<4)
      if (nargin<3)
        N = 8;
        M = 8;
      else
        M = N;
      end
    else 
      if (mod(M, N)~=0) error('M must be an integer multiple of N'); end
    end
  end
end
 if ((opthuff==true) && (nargout==1)) error('Must output bits and huffval if optimising huffman tables'); end
%LBT on image
LBTim = LBT(X,8,sqrt(2));

% DCT on input image X.
fprintf(1, 'Forward %i x %i DCT\n', N, N);
C8=dct_ii(N);
Y=colxfm(colxfm(LBTim,C8)',C8)'; 
% [xsize,ysize]=size(Y);
%Second DCT layer
% Y(1:8,1:8)=colxfm(colxfm(Y(1:8,1:8),C8)',C8)';

%Apply LBT

% Quantise to integers.
fprintf(1, 'Quantising to step size of %i\n', qstep); 
Yq=dctquantise(Y,qstep);
% Yq=quant1(Y,qstep,qstep); %This does normal quantisation, for comparison
%sake

% Generate zig-zag scan of AC coefs.
% scan = [17,9,2,10,11,3,4,18,19,25,12,5,26,13,20,6,27,33,34,28,14,21,35,41,7,36,49,22,58,29,59,43,42,50,57,60,15,30,37,51,8,61,23,52,38,31,44,16,62,24,32,64,48,63,39,53,56,46,45,40,54,55,47];
scan = diagscan(M);

% On the first pass use default huffman tables.
disp('Generating huffcode and ehuf using default tables')
[dbits, dhuffval] = huffdflt(1);  % Default tables.
[huffcode, ehuf] = huffgen(dbits, dhuffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
disp('Coding rows')
sy=size(Yq);
t = 1:M;
huffhist = zeros(16*16,1);
vlc = [];
dccur=0;
for r=0:M:(sy(1)-M),
  vlc1 = [];
  for c=0:M:(sy(2)-M),
    yq = Yq(r+t,c+t);
    % Possibly regroup 
    if (M > N) yq = regroup(yq, N); end
    % Encode DC coefficient first
    yq(1) = yq(1) + 2^(dcbits-1);
    if ((yq(1)<1) | (yq(1)>(2^dcbits-1)))
      error('DC coefficients too large for desired number of bits');
    end
    dccoef = [yq(1)  dcbits]; 
    % Encode the other AC coefficients in scan order
    ra1 = runampl(yq(scan));
    vlc1 = [vlc1; dccoef; huffenc(ra1, ehuf)]; % huffenc() also updates huffhist.
  end
  vlc = [vlc; vlc1];
end

% Return here if the default tables are sufficient, otherwise repeat the
% encoding process using the custom designed huffman tables.
if (opthuff==false) 
  if (nargout>1)
    bits = dbits;
    huffval = dhuffval;
  end
  fprintf(1,'Bits for coded image = %d\n', sum(vlc(:,2)));
  return;
end

% Design custom huffman tables.
disp('Generating huffcode and ehuf using custom tables')
[dbits, dhuffval] = huffdes(huffhist);
[huffcode, ehuf] = huffgen(dbits, dhuffval);

% Generate run/ampl values and code them into vlc(:,1:2).
% Also generate a histogram of code symbols.
disp('Coding rows (second pass)')
t = 1:M;
huffhist = zeros(16*16,1);
vlc = [];
for r=0:M:(sy(1)-M),
  vlc1 = [];
  for c=0:M:(sy(2)-M),
    yq = Yq(r+t,c+t);
    % Possibly regroup 
    if (M > N) yq = regroup(yq, N); end
    % Encode DC coefficient first
    yq(1) = yq(1) + 2^(dcbits-1);
    dccoef = [yq(1)  dcbits]; 
    % Encode the other AC coefficients in scan order
    ra1 = runampl(yq(scan));
    vlc1 = [vlc1; dccoef; huffenc(ra1, ehuf)]; % huffenc() also updates huffhist.
  end
  vlc = [vlc; vlc1];
end
fprintf(1,'Bits for coded image = %d\n', sum(vlc(:,2)))
fprintf(1,'Bits for huffman table = %d\n', (16+max(size(dhuffval)))*8)

if (nargout>1)
  bits = dbits;
  huffval = dhuffval';
end

return
