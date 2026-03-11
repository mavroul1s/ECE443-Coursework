clear; clc;

Fs = 16000; 
duration = 3; % Seconds to record

disp('--- PREPARE TO SPEAK ---');
recObj = audiorecorder(Fs, 16, 1);
pause(1);
disp('GO! Recording for 3 seconds...');
recordblocking(recObj, duration);
disp('Recording Finished.');

y = getaudiodata(recObj);
audiowrite('my_voice.wav', y, Fs);
disp('Saved: my_voice.wav');

%  Apply Robot Effect (Question 4)
disp('Applying Robot Effect...');
y_robot = QUESTION4('my_voice.wav');
audiowrite('my_robot_voice.wav', y_robot, Fs);
disp('Saved: my_robot_voice.wav');

% Compare Playback
disp('Playing Original...');
sound(y, Fs);
pause(duration + 1);

disp('Playing Robot Voice...');
sound(y_robot, Fs);

% --- Brief Comments ---
fprintf('\n--- Observations ---\n');
fprintf('The robot effect works on my voice similarly to the sample.\n');
fprintf('Personal characteristics (accent, speed) remain, but pitch is flattened to 120Hz.\n');