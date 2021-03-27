function [Data, SubjectVec] = GenerateSubjectSurfaceDataROI(OptGenData, ROI, Cdt)

    OptGenData = SetParametersProfileSimulation(OptGenData, ROI, Cdt);

    [Data, SubjectVec] = GenerateSubjectSurfaceData(OptGenData);

end
