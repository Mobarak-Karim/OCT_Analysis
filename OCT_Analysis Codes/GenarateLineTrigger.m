function  [nWareHouseAlineTriggerperFrame]= GenarateLineTrigger(ntimePerAlineWr2Clock, nlinePerFrame,dTriggerDurationWr2clock)

%% generate 

SingleAlineTrigger= zeros(1,ntimePerAlineWr2Clock);
SingleAlineTrigger(1:dTriggerDurationWr2clock)= ones(1,dTriggerDurationWr2clock);

nWareHouseAlineTriggerperFrame= repmat(SingleAlineTrigger,[1,nlinePerFrame]);

% for(nAline= 1:nlinePerFrame) %nlinePerFrame
%
% nnWareHouseAlineTriggerperFrame= cat(2,
% nWareHouseAlineTriggerperFrame,SingleAlinetrigger);
% end 

end




