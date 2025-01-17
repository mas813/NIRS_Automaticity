%Chagingparams, create new conditions in 1 trial, currently only need to
%use it fors the first block for preintervention trials.
function adaptData= AddingConditionsNirs(in,NewConditions,indexNewCond,description, oldConditionName)

% find the index for the label singleStanceSpeedFastAbsANK
idxfast=find(compareListsNested({'singleStanceSpeedFastAbsANK'},in.data.labels)==1);
idxslow=find(compareListsNested({'singleStanceSpeedSlowAbsANK'},in.data.labels)==1);

trialNum = in.metaData.trialsInCondition{find(strcmp(in.metaData.conditionName,oldConditionName))};
columnIdxTrialNum=find(compareListsNested({'Trial'},in.data.labels)==1);
rowIdxForCurrentTrial = find(in.data.Data(:,columnIdxTrialNum) == trialNum);

fast=in.data.Data(:,idxfast);
slow=in.data.Data(:,idxslow);
difference=fast-slow;

% find the index with speed difference or speed at 1 but also within the
% current condition of interes
idxSplit=find(difference>400);
idxFast = f
% in.metaData.trialsInCondition{3}=3;
% in.metaData.trialsInCondition{4}=4;

for i=1:length(NewConditions)
    in.metaData.conditionName{i}=NewConditions{i};
    in.metaData.trialsInCondition{i}=i;
    in.metaData.conditionDescription{i}= description{i};
    in.data.trialTypes{i}='TM';

%     adaptData.metaData.conditionName{3}='Adaptation';
%     adaptData.metaData.conditionName{4}='Washout';
end
in.data.Data(idxSplit(1):idxSplit(end),4)=indexNewCond(1);
in.data.Data(idxSplit(end)+1:end,4)=indexNewCond(2);


%%
params={'stepLengthAsym'};
in.plotAvgTimeCourse(in,params)

adaptData=in;

save([adaptData.subData.ID 'paramsNewConditionsV2.mat'],'adaptData','-v7.3');
end 
