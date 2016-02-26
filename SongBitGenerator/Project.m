function Project(action)

% Plays songs using random intervals for a specified number of intervals
% and length of interval

addpath(genpath([getenv('HOME') '/SongBitGenerator']));
filelist = dir([getenv('HOME') '/SongBitGenerator/Songs']);
counter = 1;
for i = 1:length(filelist)
    if ~isempty(strfind(filelist(i).name,'mp3'))
        files(counter) = {filelist(i).name};
        counter = counter + 1;
    end
end

if length(strfind([filelist.name],'mp3')) > length(strfind([filelist.name],'mat'))
    savesongs(files);
end


% Possible actions:
% initialize
% close

if nargin<1,
    action = 'initialize';
end

switch action
    case 'initialize'
        oldFigNumber = watchon;
        
        figNumber = figure( ...
            'Name','Information Transfer Rate Demonstration', ...
            'NumberTitle','off', ...
            'Toolbar', 'none', ...
            'Visible','off');
        colordef(figNumber,'black')
        axes('Visible','off');
        
        text(0,.75,'Input Length of Sound Bit and Number of Sound Bits', ...
            'HorizontalAlignment','center', ...
            'FontSize', 14);

        text(-.75,0.3,'Length of Sound Bit');
        text(.4, 0.3, 'Number of Sound Bits to Play');
        
        axis([-1 1 -1 1]);
        
        % ===================================
        % Information for all buttons
        btnLen = 0.10;
        btnWid = 0.10;
        
        % ====================================
        % The START button
        xPos = 0.25;
        yPos = 0.25;
        labelStr = 'Start';
        numberCB = 'Project(''start'');';
        
        % Generic button information
        btnPos = [xPos yPos btnLen btnWid];
        startHndl = uicontrol( ...
            'Style','pushbutton', ...
            'Units','normalized', ...
            'Position',btnPos, ...
            'String',labelStr, ...
            'Interruptible','on', ...
            'Callback',numberCB);
        
        % ====================================
        % The CLOSE button
        labelStr = 'Close';
        numberCB = 'close(gcf)';
        closeHndl = uicontrol( ...
            'Style','push', ...
            'Units','normalized', ...
            'position',[0.75 yPos btnLen 0.10], ...
            'string',labelStr, ...
            'call',numberCB);
        
        % ====================================
        % The BIT LENGTH button
        bitlengthHndl = uicontrol( ...
            'Style','edit', ...
            'String','1', ...
            'Units','normalized', ...
            'position',[0.20 0.5 0.20 0.10]);
        
        % ====================================
        % The NUMBER OF SOUND BITS button
        numberHndl = uicontrol( ...
            'Style','edit', ...
            'String','1', ...
            'Units','normalized', ...
            'position',[0.70 0.5 0.20 0.10]);
        % Uncover the figure
        hndlList = [startHndl closeHndl bitlengthHndl numberHndl];
        set(figNumber,'Visible','on', ...
            'UserData',hndlList);
        
        watchoff(oldFigNumber);
        figure(figNumber);
        
    case 'start'
        figNumber = gcf;
        hndlList = get(figNumber,'UserData');
        startHndl = hndlList(1);
        closeHndl = hndlList(2);
        bitlengthHndl = hndlList(3);
        numberHndl = hndlList(4);
        bitlength = str2double(get(bitlengthHndl,'String'));
        number = str2double(get(numberHndl,'String'));
        set([startHndl closeHndl],'Enable','off');
        for i = 1:number
            playSoundBit(files{ceil(rand*length(files))},bitlength);
            pause(bitlength*1.1);
        end
        set([startHndl closeHndl],'Enable','on');
end


