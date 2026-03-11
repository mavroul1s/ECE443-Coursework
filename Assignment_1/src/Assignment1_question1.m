clear; close all; clc;

[sample1, fs1] = audioread('C:\Users\nickb\Documents\MATLAB\voice and sound processing\Assignment1\sample1.wav'); % 'add'
[sample2, fs2] = audioread('C:\Users\nickb\Documents\MATLAB\voice and sound processing\Assignment1\sample2.wav'); % 'cats'

window_narrow = hamming(round(0.025*fs1));  % 25 ms
noverlap_narrow = round(0.015*fs1);
window_wide   = hamming(round(0.005*fs1));  % 5 ms
noverlap_wide = round(0.003*fs1);
nfft = 1024;

figure;
spectrogram(sample1, window_narrow, noverlap_narrow, nfft, fs1, 'yaxis');
title('Narrowband Spectrogram - sample1.wav');
colormap jet; colorbar; caxis([-100 0]);
ylabel('Frequency (kHz)'); xlabel('Time (s)');

figure;
spectrogram(sample1, window_wide, noverlap_wide, nfft, fs1, 'yaxis');
title('Wideband Spectrogram - sample1.wav');
colormap jet; colorbar; caxis([-100 0]);
ylabel('Frequency (kHz)'); xlabel('Time (s)');

figure;
spectrogram(sample2, window_narrow, noverlap_narrow, nfft, fs2, 'yaxis');
title('Narrowband Spectrogram - sample2.wav');
colormap jet; colorbar; caxis([-100 0]);
ylabel('Frequency (kHz)'); xlabel('Time (s)');

figure;
spectrogram(sample2, window_wide, noverlap_wide, nfft, fs2, 'yaxis');
title('Wideband Spectrogram - sample2.wav');
colormap jet; colorbar; caxis([-100 0]);
ylabel('Frequency (kHz)'); xlabel('Time (s)');
 
