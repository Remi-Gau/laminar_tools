%% (C) Copyright 2020 Remi Gau

clear;
clc;

OptGenData.NbSubject = 100;
OptGenData.NbRuns = 20;
OptGenData.NbLayers = 6;

OneRoi(OptGenData);
TwoRois(OptGenData);
TwoRoisSeveralConditions(OptGenData);
OneRoiTwoConditionsDifference(OptGenData);

function OneRoi(OptGenData)

    close all;

    %% Plot one ROI / Condition

    %%
    [Data, SubjectVec] = GenerateGroupDataROI(OptGenData, 1, 1);
    Opt.Specific{1}.Data = Data;
    Opt.Specific{1}.SubjectVec = SubjectVec;
    Opt.Specific{1}.ConditionVec = ones(size(Data, 1), 1);
    Opt.Specific{1}.RoiVec = ones(size(Data, 1), 1);

    Opt.Specific{1}.Titles = 'ROI 1 - Condition Name';
    Opt.Specific{1}.XLabel = {'ROI 1'};

    %%
    Opt.Title = 'Figure title';

    PlotProfileAndBetas(Opt);
    PrintFigure(pwd);

end

function TwoRois(OptGenData)

    %%
    [Data1, SubjectVec1] =  GenerateGroupDataROI(OptGenData, 1, 1);
    [Data2, SubjectVec2] =  GenerateGroupDataROI(OptGenData, 1, 2);

    Data = cat(1, Data1, Data2);
    SubjectVec = cat(1, SubjectVec1, SubjectVec2);

    Opt.Specific{1}.Data = Data;
    Opt.Specific{1}.SubjectVec = SubjectVec;
    Opt.Specific{1}.ConditionVec = [ones(size(Data1, 1), 1); ones(size(Data2, 1), 1)];
    Opt.Specific{1}.RoiVec = [ones(size(Data1, 1), 1); 2 * ones(size(Data2, 1), 1)];

    Opt.Specific{1}.Titles = 'Condition 1';
    Opt.Specific{1}.XLabel = {'ROI 1', 'ROI 2'};

    %%
    Opt.Title = 'Condition 1 in ROi 1 and 2';

    PlotProfileAndBetas(Opt);
    PrintFigure(pwd);

end

function TwoRoisSeveralConditions(OptGenData)

    %%
    iColumn = 1;

    Opt.Specific{1, iColumn}.Titles = 'Condition 1';
    Opt.Specific{1, iColumn}.XLabel = {'ROI 1', 'ROI 2'};

    [Data1, SubjectVec1] =  GenerateGroupDataROI(OptGenData, 1, 1);
    [Data2, SubjectVec2] =  GenerateGroupDataROI(OptGenData, 1, 2);

    Data = cat(1, Data1, Data2);
    SubjectVec = cat(1, SubjectVec1, SubjectVec2);

    Opt.Specific{1, iColumn}.Data = Data;
    Opt.Specific{1, iColumn}.SubjectVec = SubjectVec;
    Opt.Specific{1, iColumn}.ConditionVec = [ones(size(Data1, 1), 1); ones(size(Data2, 1), 1)];
    Opt.Specific{1, iColumn}.RoiVec = [ones(size(Data1, 1), 1); 2 * ones(size(Data2, 1), 1)];

    %%
    iColumn = 2;

    Opt.Specific{1, iColumn}.Titles = 'Condition 2';
    Opt.Specific{1, iColumn}.XLabel = {'ROI 1', 'ROI 2'};

    [Data1, SubjectVec1] =  GenerateGroupDataROI(OptGenData, 2, 1);
    [Data2, SubjectVec2] =  GenerateGroupDataROI(OptGenData, 2, 2);

    Data = cat(1, Data1, Data2);
    SubjectVec = cat(1, SubjectVec1, SubjectVec2);

    Opt.Specific{1, iColumn}.Data = Data;
    Opt.Specific{1, iColumn}.SubjectVec = SubjectVec;
    Opt.Specific{1, iColumn}.ConditionVec = [2 * ones(size(Data1, 1), 1); 2 * ones(size(Data2, 1), 1)];
    Opt.Specific{1, iColumn}.RoiVec = [ones(size(Data1, 1), 1); 2 * ones(size(Data2, 1), 1)];

    %%
    Opt.Title = 'Condition 1 and 2 in ROi 1 and 2';

    PlotProfileAndBetas(Opt);
    PrintFigure(pwd);

end

function OneRoiTwoConditionsDifference(OptGenData)

    Opt.IsDifferencePlot = true();

    %%
    iColumn = 1;

    Opt.Specific{1, iColumn}.Titles = ' ';
    Opt.Specific{1, iColumn}.XLabel = {'Cdt 1', 'Cdt 2'};

    [Data1, SubjectVec1] =  GenerateGroupDataROI(OptGenData, 1, 1);
    [Data2, SubjectVec2] =  GenerateGroupDataROI(OptGenData, 1, 2);

    Data = cat(1, Data1, Data2);
    SubjectVec = cat(1, SubjectVec1, SubjectVec2);

    Opt.Specific{1, iColumn}.Data = Data;
    Opt.Specific{1, iColumn}.SubjectVec = SubjectVec;
    Opt.Specific{1, iColumn}.ConditionVec = [ones(size(Data1, 1), 1); 2 * ones(size(Data2, 1), 1)];
    Opt.Specific{1, iColumn}.RoiVec = [ones(size(Data1, 1), 1); ones(size(Data2, 1), 1)];

    Opt.Specific{1, iColumn}.LineColors = [256 127 127
                                           127 256 127] / 256;

    %%
    iColumn = 2;

    Opt.Specific{1, iColumn}.Titles = '';
    Opt.Specific{1, iColumn}.XLabel = {'Difference'};

    [Data, SubjectVec] = GenerateGroupDataROI(OptGenData, 1, 1);
    Opt.Specific{1, iColumn}.Data = Data;
    Opt.Specific{1, iColumn}.SubjectVec = SubjectVec;
    Opt.Specific{1, iColumn}.ConditionVec = ones(size(Data, 1), 1);
    Opt.Specific{1, iColumn}.RoiVec = ones(size(Data, 1), 1);

    %%
    Opt.Title = 'Condition 1 and 2 in ROi 1';

    PlotProfileAndBetas(Opt);
    PrintFigure(pwd);

end
