function[] = savesongs(files)
    addpath(genpath('/Users/alexrockhill/Documents/UW/Winter 2016 UW/NBIO 450'));
    for i = 1:length(files)
        [song,fs] = audioread(files{i});
        if exist(strcat('/Users/alexrockhill/Documents/UW/Winter 2016 UW/NBIO 450/Songs/', ...
            files{i}(1:end-4),'.mat'),'file') == 0
            save(strcat('/Users/alexrockhill/Documents/UW/Winter 2016 UW/NBIO 450/Songs/', ...
                files{i}(1:end-4),'.mat'), 'song');
        end
        save('/Users/alexrockhill/Documents/UW/Winter 2016 UW/NBIO 450/fs.mat','fs');
    end
end