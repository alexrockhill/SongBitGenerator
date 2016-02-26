function[] = playSoundBit(song, bitlength)
    load([song(1:end-4) '.mat']); load('fs.mat');
    start = floor(rand*length(song));
    range = start:start+bitlength*fs;
    soundsc(song(range),fs);
end