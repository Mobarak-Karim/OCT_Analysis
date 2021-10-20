function [nWareHouseGalvoVoltagePerFrame]= GenerateFastGalvoWaveform(dgalvoYMax,dgalvoYMin, nlinePerFrame,ntimePerAlineWr2Clock,nPointsPerGalvoPos)

%% calculation 

dVoltageIncrement= (dgalvoYMax-dgalvoYMin)/nlinePerFrame;
GalvoVoltageVector= dGalvoYMin: dVoltageIncrement: dGalvoYMax- dVoltageIncrement;

nWareHouseGalvoVoltagePerFrame= [];


for (nAline= 1: nPointsPerGalvoPos:nlinePerFrame)   
    
    nWareHouseGalvoVoltagePerFrame= cat(2,nWareHouseGalvoVoltagePerFrame, ones(1,ntimePerAlineWr2Clock*nPointsPerGalvoPos)*GalvoVoltageVector(nAline));
    
end

end
     
    





