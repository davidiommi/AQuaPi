
%% Input parameters:
    PVC.pathOfPET='';
    PVC.pathOfhighResMask='';
    PVC.pathOfBrainMasks= '';
    PVC.pathOfpMoCohighResMask='';
    PVC.pathOfpMoCoBrainMasks= '';
    PVC.pathOfReconParam= '';
    PVC.pathToMRcorrespondenceFile= '';
    PVC.whereToProcess='';
%% Post-processing parameters, which needed to be updated based on experiments.

    [dateVector]=getDatesFromDcmInfo(PVC.pathOfPET)

    % Automatically calibrate the crosscalibration factor based on date.
    
    tLower1=datetime(2016,04,11); tUpper1=datetime(2016,06,17)
    tLower2=datetime(2016,06,25); tUpper2=datetime(2016,10,13)
    tLower3=datetime(2016,10,24); tUpper3=datetime(2017,1,12)
    tLower4=datetime(2017,01,23); tUpper4=datetime(2017,04,25)

    % For every new block of cross-calibration interval, the bottom code
    % needs to be appended in the following syntax:
    
    % if isbetween(datevector,tLowerX,tUpperX)
    %  PVC.crossCalibrationFactor=X.XXX
    % end
    
    if isbetween(dateVector,tLower1,tUpper1)
       PVC.crossCalibrationFactor=1.141
    end
    if isbetween(dateVector,tLower2,tUpper2)
       PVC.crossCalibrationFactor=1.126;
    end
    if isbetween(dateVector,tLower3,tUpper3)
       PVC.crossCalibrationFactor=1.111;
    end
    if isbetween(dateVector,tLower4,tUpper4)
       PVC.crossCalibrationFactor= 1.0880
    end

%% Hard-coded variables   

    PVC.psfFWHM= 5
    PVC.P2Bratio=1.06 % plasma to blood ratio
    PVC.petMoCo=false; % MR based MoCo only.
    PVC.AC='CT'; % Type of attenuation map - optional
    = [pathSuffix,subjectID{lp},'/Processed data'];
    % to comment out
   % r=[]; 
    % to comment out
    [pvcOutputs] = tempPVC2(PVC,r);
%     if strcmp(acMaps,'RESOLUTE')
%         resoluteAUC1(lp)=pvcOutputs.rAUC1;
%         resoluteAUC2(lp)=pvcOutputs.rAUC2;
%         resoluteAUC(lp)=pvcOutputs.rAUC;
%     else
%         if strcmp(acMaps,'PCT')
%             PCTauc1(lp)=pvcOutputs.rAUC1;
%             PCTauc2(lp)=pvcOutputs.rAUC2;
%             PCTauc(lp)=pvcOutputs.rAUC;
%         end
%     end
    %rawArtery{lp}(ilp)=pvcOutputs.arteryTACarea;
%     rawAUC{lp}(ilp)= pvcOutputs.rawAUC;
end
end
% resoluteAUC1=resoluteAUC1';
% resoluteAUC2=resoluteAUC2';
% resoluteAUC=resoluteAUC';
% PCTauc=PCTauc';
% PCTauc1=PCTauc1';
% PCTauc2=PCTauc2';
% T=table(subjectID,resoluteAUC,resoluteAUC1,resoluteAUC1,resoluteAUC2,PCTauc,PCTauc1,PCTauc2);
% cd(whereToStoreResults)
% writetable(T);
toc