function [GelvoXVoltageVector,dVoltageIncrementX]= GenerateSlowGalvoWaveform(dgalvoXMax,dgalvoXMin, nlinePerFrame)

%% calculation of waveform
dVoltageIncrementX=(dgalvoXMax - dgalvoXMin)/nFramesPerVolume;
GelvoXVoltageVector= ones(1, nlinePerFrame*nTimePerAlineWr2Clock)*dGalvoXMin + dVoltageIncrementX*(nFrame-1);

end

