function out = my_lpc(file)

[sig, Fs] = audioread(file);

Horizon = 30;  %30ms - window length
OrderLPC=24;   %order of LPC
Buffer = 0;    % initialization
out = zeros(size(sig)); % initialization

Horizon = Horizon*Fs/1000;
Shift = Horizon/2;       % frame size - step size
Win = hanning(Horizon);  % analysis window

Lsig = length(sig);
slice = 1:Horizon;
tosave = 1:Shift;
Nfr = floor((Lsig-Horizon)/Shift)+1;  % number of frames

% analysis frame-by-frame
for l=1:Nfr
    
  sigLPC = Win.*sig(slice);
  en = sum(sigLPC.^2); % get the short - term energy of the input
  
  % LPC analysis
  %  compute autocorrelation
  r_full = xcorr(sigLPC, OrderLPC);      % length = 2*OrderLPC+1
  r = r_full(OrderLPC+1 : end);          % extract lags 0..OrderLPC


  % Levinson to get LPC coefficients a (a(1)=1)
  a = zeros(OrderLPC+1,1);
  a(1) = 1;
  E = r(1);
  if E == 0
      E = 1e-8; % small floor to avoid division by zero
  end
  for m = 1:OrderLPC
      % compute reflection coefficient
      if m == 1
          acc = r(2);
      else
          acc = r(m+1) + sum( a(2:m) .* r(m:-1:2) );
      end
      lambda = - acc / E;
      % update LPC coefficients
      a_old = a;
      for i = 2:m
          a(i) = a_old(i) + lambda * a_old(m - i + 2);
      end
      a(m+1) = lambda;
      % update prediction error
      E = E * (1 - lambda^2);
      if E <= 0
          E = 1e-8;
      end
  end
  a = a.'; % row vector

  % gain of the LP filter (sqrt of final prediction error)
  G = sqrt(E);

  %  linear prediction error by inverse filtering
  ex = filter(a, 1, sigLPC);
  
  % synthesis
  s = filter(G,a, ex);
  ens = sum(s.^2);   % get the short-time energy of the output
  g = sqrt(en/ens);  % normalization factor
  s  =s*g;           % energy compensation
  s(1:Shift) = s(1:Shift) + Buffer;  % Overlap and add
  out(tosave) = s(1:Shift);           % save the first part of the frame
  Buffer = s(Shift+1:Horizon);       % buffer the rest of the frame
  
  slice = slice+Shift;   % move the frame
  tosave = tosave+Shift;
  
end
