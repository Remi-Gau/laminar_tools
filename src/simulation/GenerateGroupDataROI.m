%% (C) Copyright 2021 Remi Gau

function [Data, SubjectVec] = GenerateGroupDataROI(OptGenData, ROI, Cdt)

    OptGenData = SetParametersProfileSimulation(OptGenData, ROI, Cdt);

    [Data, SubjectVec] = GenerateGroupDataLaminarProfiles(OptGenData);

end
