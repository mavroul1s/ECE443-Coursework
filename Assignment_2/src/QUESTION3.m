function out = QUESTION3(infile, OrderLPC, outname)

[sig, Fs] = audioread(infile);

% Force Mono if stereo
if size(sig, 2) > 1
    sig = mean(sig, 2);
end

Horizon = 30;            % ms - window length
Horizon = round(Horizon * Fs / 1000);
OrderLPC = round(OrderLPC);
if OrderLPC < 1
    error('OrderLPC must be >= 1');
end

Shift = round(Horizon/2);
Win = hanning(Horizon);
Lsig = length(sig);
Buffer = zeros(Shift,1);
out = zeros(size(sig));
slice = 1:Horizon;
tosave = 1:Shift;
Nfr = floor((Lsig - Horizon)/Shift) + 1;

for l = 1:Nfr
    sigLPC = Win .* sig(slice);
    en = sum(sigLPC.^2); % short-term energy of input frame
    
    r_full = xcorr(sigLPC, OrderLPC);      % length = 2*OrderLPC+1
    r = r_full(OrderLPC+1 : end);          % extract lags 0..OrderLPC

    % 2. Levinson-Durbin to get a(0..P) with a(1)=1
    a = zeros(OrderLPC+1,1);
    a(1) = 1;
    E = r(1);
    if E == 0
        E = 1e-8;
    end
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
        if E <= 0
            E = 1e-8;
        end
    end
    a = a.'; % row vector [1 a1 a2 ... aP]
    G = sqrt(E);  % LP gain
    
    ex = randn(Horizon, 1);
    
    s = filter(G, a, ex);
    
    % energy normalization to match original frame energy
    ens = sum(s.^2);
    if ens == 0
        g = 1;
    else
        g = sqrt(en/ens);
    end
    s = s * g;
    
    % overlap-add
    s(1:Shift) = s(1:Shift) + Buffer;
    out(tosave) = s(1:Shift);
    Buffer = s(Shift+1:Horizon);
    
    slice = slice + Shift;
    tosave = tosave + Shift;
end

end