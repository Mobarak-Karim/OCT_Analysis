function  [GelvoXVoltageVector,yrev]= GenerateSlowGalvoWaveformWithGap(dgalvoXMax,dgalvoXMin, nlinePerFrame,ntimePerAlineWr2Clock,nFrame,nFramePerVolume,nSectionBetweenFramesWR2clock)

%% Generate slow galvo axis from a frame
[GelvoXVoltageVector,dVoltageIncrementX]= GenerateSlowGalvoWaveform(dgalvoXMax,dgalvoXMin, nlinePerFrame,ntimePerAlineWr2Clock,nFrame,nFramePerVolume);
 
 %% in between frame
 dMax = GelvoXVoltageVector(end)+ dVoltageIncrementX;
 dMin = GelvoXVoltageVector(end);
 x= 0: pi/nSectionBetweenFramesWR2clock:pi;
 amplitude = (dMax- dMin)/2;
 yrev = amplitude*cos(x)-amplitude+dMax;
end
 
 
