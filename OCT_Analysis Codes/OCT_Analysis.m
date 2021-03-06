%Mobarak 10/18/2021
%assume: galvoY= fast; galvoX= slow axis
%This code will genarate trigger signal, fast axis, alow axis based oninput signal
clc; clear all; close all;set(0,'defaultfigurecolor',[1 1 1]); 

%% Parameters
nlineRate = 30000; %30khz
dgalvoYMax=5;
dgalvoYMin=-5;
dgalvoXax= 5;
dgalvoXMin= -5;

dTiggerDuration=5; %us
dTiggerDelay= 0.2; %us

nlinePerFrame= 1024;  %A-line number
nSectionPerFrame=8;   %section of date for a frame
nSectionBetweenFrames=1;  %to introduce gap between frames

nPointsPerGalvoPos=1;   %for angiography set 4/8; for nomral acquisition set 1;

%nchunkPerVolume
nchunkBetweenvolume=2;  %to introduce gap between volume
nFramePerVolume=5;     %how many frames in a volume

%% Calcution
ntimePerAline= 1e6/nlineRate;   %T=1/F

% unit clock : let make dtriggerdelay as a unit
dTriggerDelayWR2Clock= 1;
ntimePerAlineWr2Clock= floor(ntimePerAline/dTiggerDelay);
dTriggerDurationWr2clock= dTiggerDuration/dTiggerDelay;

% keyboard
nLinePerChunk= nlinePerFrame/nSectionPerFrame;
nSectionBetweenFramesWR2clock= nLinePerChunk*nSectionBetweenFrames*ntimePerAlineWr2Clock;
nScetionBetweenVolumeWR2clock= nLinePerChunk*nFramePerVolume*ntimePerAlineWr2Clock;

%% Genarate Trigger Line, Galvo X and Y waveform

% initialization for data storage
AlineTriggerPerframeWithGap=[];
AccFastGalvoVoltageWithGap=[];
SlowGalvoVoltageWithGap= [];


f = figure();
for (nVol=1:2)
    for(nFrame= 1: nFramePerVolume)
        %% Genaate Slow Galvo voltage graph
        [GelvoXVoltageVector,yrev]= GenerateSlowGalvoWaveformWithGap(dgalvoXMax,dgalvoXMin, nlinePerFrame,ntimePerAlineWr2Clock,nFrame,nFramePerVolume,nSectionBetweenFramesWR2clock);
        
        % for a volume
        SlowGalvoVoltageWithGap = cat(2, SlowGalvoVoltageWithGap,GelvoXVoltageVector,yrev);
        
        %% Generate fast galvo voltage graph
        [FrameWithGap] = GeneratefastGalvoWaveformWithGap(dgalvoYMax,dgalvoYMin, nlinePerFrame,ntimePerAlineWr2Clock,nScetionBetweenFramesWR2clock,nPointsPerGalvoPos);
        
        % accumulate for a volume
        AccFastGalvoViltageWithGap=cat(2,AccFastGalvoViltageWithGap,FrameWithGap);
        clear FramewithGap;
        
        %% Genarate Trigger line
        [nWareHouseAlineTriggerperFrame]= GenarateLineTrigger(ntimePerAlineWr2Clock, nlinePerFrame,dTriggerDurationWr2clock);
        
        % in between frames
        [nWareHouseAlineTriggerperFrame]= GenarateLineTrigger(ntimePerAlineWr2Clock, nLinePerChunk,dTriggerDurationWr2clock);
        
        % with in between gap
        AlinetriggerPerFrameWithGap = cat(2, AlinetriggerPerFrameWithGap, nWareHouseAlineTriggerperFrame,nWareHouseAlineTriggerInBetweenFrame);
        
        % add trigger delay
        if (nVol==1) && (nFrame==1)
            AlineTriggerPerFrameWithGap = cat(2,0,AlineTriggerPerFrameWithGap);
        end 
        nFrame;
    end  % for (nFrame= 1:1)   % nFramePerVolume
    
    %% add data for in between volume
    
    % slow galvo
    [SlowGalvoVoltageWithGap] = AddDataForInbetnVol(nScetionBetweenVolumeWR2clock,dgalvoXmax, dgalvoXMin, SlowGalvovoltageWithGap);
    
    % fast galvo
    AddedGapChunk= ones(1,nScetionBetweenVolumeWR2clock)* dgalvoYMin;
    AccFastGalvoVoltageWithGap= cat(2, AccFastGalvoVoltageWithGap,AddedGapChunk );
    
    % trigger line 
    [nWareHouseAlineTriggerInBetVol]= GenarateLineTrigger(ntimePerAlineWr2Clock, nLinePerChunk*nchunkBetweenvolume,dTriggerDurationWr2clock);
    AlineTriggerPerFrameWithGap= cat(2,AlineTriggerPerFrameWithGap, nWareHouseAlineTriggerInBetVol);
    
end

%% Show Final Results
figure(f),
plot((1:lenght(SlowGalvoVoltageWithGap))/ntimePerAlineWr2Clock,SlowGalvoVoltageWithGap);hold on;
plot((1: length(AccFastGalvoVoltageWithGap))/ntimePerAlineWr2Clock, AccFastGalvoVoltageWithGap); hold on;
plot((1: length(AlineTriggerPerFrameWithGap))/ ntimePerAlineWr2Clock,-6.2+ AlineTriggerPerFrameWithGap); hold on;

%% Show the result in animation format
makeAnimation(AccFastVoltageWithGap,AlineTriggerPerFrameWithGap, SlowGalvoVoltageWithGap, ntimePerAlineWr2Clock );






    
    
    
            
        
        
        
        
        
         












