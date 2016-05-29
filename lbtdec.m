function Z = lbtdec(vlc, qstep, N, M, bits, huffval, dcbits, W, H)

% JPEGDEC Decodes a (simplified) JPEG bit stream to an image
%
%  Z = jpegdec(vlc, qstep, N, M, bits huffval, dcbits, W, H) Decodes the
%  variable length bit stream in vlc to an image in Z.
%
%  vlc is the variable length output code from jpegenc
%  qstep is the quantisation step to use in decoding
%  N is the width of the DCT block (defaults to 8)
%  M is the width of each block to be coded (defaults to N). Must be an
%  integer multiple of N - if it is larger, individual blocks are
%  regrouped.
%  if bits and huffval are supplied, these will be used in Huffman decoding
%  of the data, otherwise default tables are used
%  dcbits determines how many bits are used to decode the DC coefficients
%  of the DCT (defaults to 8)
%  W and H determine the size of the image (defaults to 256 x 256)
%
%  Z is the output greyscale image

% Presume some default values if they have not been provided
error(nargchk(2, 9, nargin, 'struct'));
opthuff = true;
if (nargin<9)
  H = 256;
  W = 256;
  if (nargin<7)
    dcbits = 8;
    if (nargin<6)
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
end

% Set up standard scan sequence
scan = diagscan(M);
% scan = [17,9,2,10,11,3,4,18,19,25,12,5,26,13,20,6,27,33,34,28,14,21,35,41,7,36,49,22,58,29,59,43,42,50,57,60,15,30,37,51,8,61,23,52,38,31,44,16,62,24,32,64,48,63,39,53,56,46,45,40,54,55,47];


if (opthuff)
  disp('Generating huffcode and ehuf using custom tables')
else
  disp('Generating huffcode and ehuf using default tables')
  [bits huffval] = huffdflt(1);
end
% Define starting addresses of each new code length in huffcode.
huffstart=cumsum([1; bits(1:15)]);
% Set up huffman coding arrays.
[huffcode, ehuf] = huffgen(bits, huffval);

% Define array of powers of 2 from 1 to 2^16.
k=[1; cumprod(2*ones(16,1))];

% For each block in the image:

% Decode the dc coef (a fixed-length word)
% Look for any 15/0 code words.
% Choose alternate code words to be decoded (excluding 15/0 ones).
% and mark these with vector t until the next 0/0 EOB code is found.
% Decode all the t huffman codes, and the t+1 amplitude codes.

eob = ehuf(1,:);
run16 = ehuf(15*16+1,:);
i = 1;
Zq = zeros(H, W);
t=1:M;
prev=0;
disp('Decoding rows')
for r=0:M:(H-M),
  for c=0:M:(W-M),
    yq = zeros(M,M);

% Decode DC coef - assume no of bits is correctly given in vlc table.
    cf = 1;
    cur = vlc(i,1) - 2^(vlc(i,2)-1);
    yq(cf) = cur + prev;
    prev = yq(cf);
    i = i + 1;

% Loop for each non-zero AC coef.
    while any(vlc(i,:) ~= eob),
      run = 0;

% Decode any runs of 16 zeros first.
      while all(vlc(i,:) == run16), run = run + 16; i = i + 1; end

% Decode run and size (in bits) of AC coef.
      start = huffstart(vlc(i,2));
      res = huffval(start + vlc(i,1) - huffcode(start));
      run = run + fix(res/16);
      cf = cf + run + 1;  % Pointer to new coef.
      si = rem(res,16);
      i = i + 1;

% Decode amplitude of AC coef.
      if vlc(i,2) ~= si,
        error('Problem with decoding .. you might be using the wrong bits and huffval tables');
        return
      end
      ampl = vlc(i,1);

% Adjust ampl for negative coef (i.e. MSB = 0).
      thr = k(si);
      yq(scan(cf-1)) = ampl - (ampl < thr) * (2 * thr - 1);

      i = i + 1;      
    end

% End-of-block detected, save block.
    i = i + 1;

    % Possibly regroup yq
    if (M > N) yq = regroup(yq, M/N); end
    Zq(r+t,c+t) = yq;
  end
end

fprintf(1, 'Inverse quantising to step size of %i\n', qstep);
Zi=dctquantise2(Zq,qstep);
% Zi=quant2(Zq,qstep,qstep);%This is for normal one step quantisation

fprintf(1, 'Inverse %i x %i DCT\n', N, N);
C8=dct_ii(N);
[xsize,ysize]=size(Zi);
%Inverting first DCT layer
% Zi(1:8,1:8)=colxfm(colxfm(Zi(1:8,1:8)',C8')',C8');
%Second DCT layer
Zo=colxfm(colxfm(Zi',C8')',C8');
Z=ILBT(Zo,8,sqrt(2));

return