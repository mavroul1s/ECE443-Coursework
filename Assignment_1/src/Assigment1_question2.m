%Record audio ("apa")
fs = 44100;          
duration = 2;       
recObj = audiorecorder(fs, 16, 1); 
disp('Speak the word "apa"');
recordblocking(recObj, duration);
disp('Recording complete.');

audioData = getaudiodata(recObj);
t = (0:length(audioData)-1)/fs; 

%Plot signal
N_ms = 200;
samplesPerSeg = round((N_ms/1000)*fs);
numSeg = floor(length(audioData)/samplesPerSeg);

figure(1);
hold on;
for i = 1:numSeg
    idx1 = (i-1)*samplesPerSeg + 1;
    idx2 = i*samplesPerSeg;
    plot(t(idx1:idx2), audioData(idx1:idx2));
end
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Speech Signal ("apa") – 200 ms Segments');
xlim([0 max(t)]);
grid on;

%Slow down the sound
slowFactor = 2;                         
y_slow = resample(audioData, slowFactor, 1); 
t_slow = (0:length(y_slow)-1)/fs;       

% Playback
disp('Playing original...');
sound(audioData, fs);
pause(duration + 0.5);
disp('Playing slowed version...');
sound(y_slow, fs); 

%Plot slowed signal 
samplesPerSegSlow = samplesPerSeg; 
numSegSlow = floor(length(y_slow)/samplesPerSegSlow);

figure(2);
hold on;
for i = 1:numSegSlow
    idx1 = (i-1)*samplesPerSegSlow + 1;
    idx2 = i*samplesPerSegSlow;
    plot(t_slow(idx1:idx2), y_slow(idx1:idx2));
end
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Slowed-Down Speech Signal – 200 ms Segments');
xlim([0 max(t)]);  
grid on;
