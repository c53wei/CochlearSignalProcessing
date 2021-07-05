% Test Filter

%sound(y,Fs1);


%separateSound("caterpillar_resampled.wav");

%function separateSound(filename)
% Reads separates the input sound by passing them thru different BPFs

[y,Fs1] = audioread("../moving_sound_resampled.wav");

% 1-5
y1 = filter(F100_500, y);
plot(y1)
sound(y1, Fs1);
rect_y1 = abs(y1);
plot(rect_y1)
xlabel('Time (s)')
ylabel('Amplitude')

% 5-7
y2 = filter(F500_700, y);
rect_y2 = abs(y2);

% 7-9
y3 = filter(F700_900, y);
rect_y3 = abs(y3);

% 9-11
y4 = filter(F900_1100, y);
rect_y4 = abs(y4);

% 11-13
y5 = filter(F1100_1300, y);
rect_y5 = abs(y5);

% 13-18
y6 = filter(F1300_1800, y);
rect_y6 = abs(y6);

% 18-2800
y7 = filter(F1800_2800, y);
rect_y7 = abs(y7);

% 2800-4800
y8 = filter(F2800_4800, y);
rect_y8 = abs(y8);

% 4800-8000 (Maybe filter out these sounds or make them quieter bc they vv
% annoying)
y9 = filter(F4800_8000, y);
rect_y9 = abs(y9);
plot(rect_y9)
%sound(y9, Fs1);

%end