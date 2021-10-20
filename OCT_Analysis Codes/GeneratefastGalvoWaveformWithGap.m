function [FrameWithGap] = GeneratefastGalvoWaveformWithGap(dgalvoYMax,dgalvoYMin, nlinePerFrame,ntimePerAlineWr2Clock,nScetionBetweenFramesWR2clock,nPointsPerGalvoPos)

%% Generate waveform of OCT data part
[nWareHouseGalvoVoltagePerFrame]= GenerateFastGalvoWaveform(dgalvoYMax,dgalvoYMin, nlinePerFrame,ntimePerAlineWr2Clock,nPointsPerGalvoPos);

  %% Generate in between Frames
  
  x= 0: 2*pi/nScetionBetweenFramesWR2clock:pi;
  amplitude = (dgalvoYMax-dgalvoYMin)/2; 
  y= amplitude*cos(x)-amplitude+ dgalvoYMax;
  
  AddedGapChunk=ones(1,nScetionBetweenFramesWR2clock)* dgalvoYMin;
  AddedGapChunk(1:nScetionBetweenFramesWR2clock/2+1)=y;
  FrameWithGap= cat(2,nWareHouseGalvoVoltagePerFrame, AddedGapChunk);
  
end
  


