% (C) Copyright 2021 Remi Gau

function [Data, SubjectVec] = GenerateSubjectSurfaceDataROI(OptGenData, ROI, Cdt)

    OptGenData = SetParametersProfileSimulation(OptGenData, ROI, Cdt);

    [Data, SubjectVec] = GenerateSubjectSurfaceData(OptGenData);

end
