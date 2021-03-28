%% (C) Copyright 2021 Remi Gau

function OptGenData = SetParametersProfileSimulation(OptGenData, ROI, Cdt)
    
    BETAS = ReturnSimulationParameters();
    
    Cst = BETAS(ROI).values(Cdt, 1);
    Lin = BETAS(ROI).values(Cdt, 2);
    Quad = BETAS(ROI).values(Cdt, 3);
    
    OptGenData.StdDevBetweenSubject = 0.1;
    OptGenData.StdDevWithinSubject = 0.1;
    
    OptGenData.Betas = [Cst; Lin; Quad];
    
end

function BETAS = ReturnSimulationParameters()
    
    iROI = 1;
    BETAS(iROI).values = [...
        0.1767,  0.2359, -0.0594; ... % Target
        -0.3948, -0.0500, -0.0117];    % Stim
    %    Cst      Lin      Quad
    
    
    iROI = 2;
    BETAS(iROI).values = [...
        -5, 0.8, 0.1; ...
        2,  -0.4, 0.1];
    
end
