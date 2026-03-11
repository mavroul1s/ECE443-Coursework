
clear; clc;

infile = 'sample.wav';   
orders = [60, 2];       
default_out = 'whisper_utput.wav';  % per assignment example

fprintf('Running whispered synthesis for orders: %s\n', mat2str(orders));

for i = 1:length(orders)
    ord = orders(i);
    outname = sprintf('whisper_order%d.wav', ord);
    fprintf('Processing order = %d  --> output file: %s\n', ord, outname);
    
    y = QUESTION3(infile, ord, outname);
    
    [x, Fs] = audioread(infile);
    audiowrite(outname, y, Fs);
    
    % play the whisper output 
    fprintf('Playing whispered output for order %d...\n', ord);
    sound(y, Fs);
    pause(length(y)/Fs + 0.5);
end

% Brief observations printed to console:
fprintf('\nObservations (brief):\n');
fprintf('- Whispering replaces the periodic/voiced excitation with noise, so the\n  synthesized speech loses the strong periodicity and pitch cues (no clear\n  fundamental frequency). The result sounds breathy/whisper-like.\n');
fprintf('- Intelligibility: vowels and formant structure are still present via the\n  LPC filter, so many words remain intelligible, but consonants that rely on\n  voicing or pitch cues may be less clear.\n');
fprintf('- LP order effects:\n');
fprintf('   * Higher LP order (e.g. 60) captures more spectral detail (narrower\n     formant peaks)\n     order.\n');
fprintf('   * Lower LP order (e.g. 6) gives a smoother envelope, broader formants,\n     which can reduce clarity of some phonemes.\n');
fprintf('\nFiles created: %s, %s\n', sprintf('whisper_order%d.wav',orders(1)), sprintf('whisper_order%d.wav',orders(2)));
fprintf('\nDone.\n');
