% test_my_lpc.m
clear; clc;

infile = 'sample.wav';

out = my_lpc(infile);

% Load original to get sampling rate
[x, Fs] = audioread(infile);

audiowrite('lpc_output.wav', out, Fs);

disp('Playing original speech...');
sound(x, Fs);
pause(length(x)/Fs + 0.5);

disp('Playing LPC-synthesized speech...');
sound(out, Fs);
pause(length(out)/Fs + 0.5);

disp('Finished.The two sammples sound identical');
