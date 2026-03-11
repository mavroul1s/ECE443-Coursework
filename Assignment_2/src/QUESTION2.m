function out = QUESTION2(file, OrderLPC)

[sig, Fs] = audioread(file);


if size(sig, 2) > 1
    sig = mean(sig, 2);
end

Horizon = 30;  % 30ms
Buffer = 0;    
out = zeros(size(sig)); 

Horizon = round(Horizon*Fs/1000); 
Shift = round(Horizon/2);       
Win = hanning(Horizon);  


PitchFreq = 120; % Hz
PitchPeriod = round(Fs/PitchFreq); 

Lsig = length(sig);
slice = 1:Horizon;
tosave = 1:Shift;
Nfr = floor((Lsig-Horizon)/Shift)+1; 

for l=1:Nfr
    
  sigLPC = Win.*sig(slice);
  en = sum(sigLPC.^2); 
  
  % LPC analysis
  r_full = xcorr(sigLPC, OrderLPC);      
  r = r_full(OrderLPC+1 : end);          

  % Levinson Durbin
  a = zeros(OrderLPC+1,1);
  a(1) = 1;
  E = r(1);
  if E == 0, E = 1e-8; end
  
  for m = 1:OrderLPC
      if m == 1
          acc = r(2);
      else
          acc = r(m+1) + sum( a(2:m) .* r(m:-1:2) );
      end
      lambda = - acc / E;
      a_old = a;
      for i = 2:m
          a(i) = a_old(i) + lambda * a_old(m - i + 2);
      end
      a(m+1) = lambda;
      E = E * (1 - lambda^2);
      if E <= 0, E = 1e-8; end
  end
  a = a.'; 

  ex_robot = zeros(size(sigLPC));
  ex_robot(mod(slice, PitchPeriod) == 0) = 1; 

  % Synthesis
  s = filter(1, a, ex_robot);  
  
  % Energy Normalization (Matches volume to original)
  ens = sum(s.^2);   
  if ens < 1e-9, ens = 1e-9; end
  g = sqrt(en/ens);  
  s = s*g;           
  
  % Overlap-Add
  s(1:Shift) = s(1:Shift) + Buffer;  
  out(tosave) = s(1:Shift);           
  Buffer = s(Shift+1:Horizon);       
  
  slice = slice+Shift;   
  tosave = tosave+Shift;
end