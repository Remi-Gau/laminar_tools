% (C) Copyright 2021 Remi Gau

function Data = GenerateSubjectSurfaceDataRaster(Opt, iSubject)
    %
    % generate data to be used for raster plotting
    %

    if nargin < 2
        iSubject = 1;
    end

    DesMat = SetDesignMatLamGlm(Opt.NbLayers, true);

    Betas = Opt.Betas + randn(size(Opt.Betas)) * Opt.StdDevBetweenSubject;

    Mu = DesMat * Betas;

    Sigma = GetCrossLaminarErrorCovarianceMatrix(Opt);

    TemplateData = mvnrnd(Mu, Sigma, Opt.NbVertices(iSubject));

    % Generate a new mean profile for each run of this subject
    % and generate data for this run

    for iRun = 1:Opt.NbRuns

        Data(:, :, iRun) = TemplateData + ...
            randn(size(TemplateData)) * Opt.StdDevWithinSubject + ...
            randn(size(TemplateData)); %#ok<*AGROW>

    end

end
