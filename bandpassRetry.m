% Generate log spaced intervals between 100Hz and 10000Hz
intervals = logspace(2,log10(8000),10); % generates n points between decades 10^a and 10^b.
audiofile = 'radio_resampled.wav';
[signal, Fs_data] = audioread(audiofile);
band_1 = filter(NewBand(intervals(1), intervals(2)), signal);
band_2 = filter(NewBand(intervals(2), intervals(3)), signal);
band_3 = filter(NewBand(intervals(3), intervals(4)), signal);
band_4 = filter(NewBand(intervals(4), intervals(5)), signal);
band_5 = filter(NewBand(intervals(5), intervals(6)), signal);
band_6 = filter(NewBand(intervals(6), intervals(7)), signal);
band_7 = filter(NewBand(intervals(7), intervals(8)), signal);
band_8 = filter(NewBand(intervals(8), intervals(9)), signal);
band_9 = filter(NewBand(intervals(9), intervals(10)-51), signal);
sound(band_9, 16000);
