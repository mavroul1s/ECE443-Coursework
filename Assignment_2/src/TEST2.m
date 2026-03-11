clear; clc;

filename = 'sample.wav';

[~, Fs] = audioread(filename);

disp('--- Generating 3 Robot Voices ---');

% Low Quality (Order 4) 
% This will sound muffled
disp('1. Generating Order 4 (Low)...');
out_low = QUESTION2(filename, 4);
audiowrite('robot_order4.wav', out_low, Fs);

% Medium Quality (Order 16) 
% This captures the main vowels but might miss fine buzzing details.
disp('2. Generating Order 16 (Medium)...');
out_mid = QUESTION2(filename, 16);
audiowrite('robot_order16.wav', out_mid, Fs);

% High Quality (Order 40)
% This should sound the crispest and "buzziest".
disp('3. Generating Order 40 (High)...');
out_high = QUESTION2(filename, 40);
audiowrite('robot_order40.wav', out_high, Fs);

disp('------------------------------------------------');
disp('Files saved. Now playing results...');

fprintf('Playing Order 4 (Low)... ');
sound(out_low, Fs);
pause(length(out_low)/Fs + 1); % Wait for audio to finish + 1 sec
fprintf('Done.\n');

fprintf('Playing Order 16 (Mid)... ');
sound(out_mid, Fs);
pause(length(out_mid)/Fs + 1);
fprintf('Done.\n');

fprintf('Playing Order 40 (High)... ');
sound(out_high, Fs);
fprintf('Done.\n');

disp('------------------------------------------------');
disp('Test Complete.');