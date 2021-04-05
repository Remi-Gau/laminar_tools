% (C) Copyright 2021 Remi Gau

function [Data, SortingData, Beta] = SortRaster(Data, SortingData, Opt, Parameter)
    %
    % Sorts Data for raster given SortingData along the profile Parameter
    %
    % USAGE::
    %
    %  [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, Parameter)
    %
    % Parameter can be `Cst`, `Lin`, `Quad`
    %
    % The SortingData returned represents the outcome of:
    %
    %   [SortingData] = SortRaster(SortingData, SortingData, Opt, Parameter)
    %
    % In other words the sorting data returned is sorted by itself and averaged
    % (across folds if cross-validated) to be withing the same "range" as the
    % sorted data.
    %
    % Sorting can be done in cross-validated fashion across runs if set so in
    % ``Opt.Raster.CrossValidate``
    %
    % Deconvolution of the data across layers is done if
    % ``Opt.PerformDeconvolution`` is set to ``true()``.
    %
    % Data and SortingData can be cells
    %

    if ~Opt.Raster.Sort
        Beta = [];
        return
    end

    % If we are dealing with "group" data
    % we make loop through each subject
    % and sort with a recursive to SortRaster
    if iscell(Data) && iscell(SortingData)

        for iSub = 1:size(Data, 1)
            [Data{iSub}, SortingData{iSub}, Beta{iSub}] = SortRaster( ...
                                                                  Data{iSub}, ...
                                                                  SortingData{iSub}, ...
                                                                  Opt, ...
                                                                  Parameter);
        end

        return
    end

    if ~all(size(Data) == size(SortingData))
        error('Sorting data and data to sort should have the same size.');
    end

    Quad = true;
    DesignMatrix = SetDesignMatLamGlm(Opt.NbLayers, Quad);

    if ~Opt.Raster.CrossValidate

        SortingData = mean(SortingData, 3);
        Data = mean(Data, 3);

        [Data, SortingData, Beta] = SortThisRaster(Data, SortingData, DesignMatrix, Opt, Parameter);

    else

        NbRuns = size(Data, 3);

        for iFold = 1:NbRuns

            SortingFold = false(NbRuns, 1);
            SortingFold(iFold) = true;

            SortedFolds = true(NbRuns, 1);
            SortedFolds(iFold) = false;

            SortingFoldData = SortingData(:, :, SortingFold);

            % Apply the sorting to the left out fold of the data
            % and sorting data to return both
            SortedFoldsData = mean(Data(:, :, SortedFolds), 3);
            [DataTemp(:, :, iFold), Beta(iFold)] = SortThisRaster(SortedFoldsData, ...
                                                               SortingFoldData, ...
                                                               Opt, ...
                                                               DesignMatrix, ...
                                                               Parameter); %#ok<*AGROW>

            SortedFoldsData = mean(SortingData(:, :, SortedFolds), 3);

            [SortingDataTemp(:, :, iFold)] = SortThisRaster(SortedFoldsData, ...
                                                            SortingFoldData, ...
                                                            Opt, ...
                                                            DesignMatrix, ...
                                                            Parameter); %#ok<*AGROW>

        end

        SortingData = mean(SortingDataTemp, 3);
        Data = mean(DataTemp, 3);
        Beta = mean(Beta);

    end

end

function [Data, Beta] = SortThisRaster(Data, SortingData, Opt, DesignMatrix, Parameter)

    switch lower(Parameter)
        case 'cst'
            Keep = 1;
        case 'lin'
            Keep = 2;
        case 'quad'
            Keep = 3;
    end

    if Opt.PerformDeconvolution
        Data = PerfomDeconvolution(Data, Opt.NbLayers);
        SortingData = PerfomDeconvolution(SortingData, Opt.NbLayers);
    end

    SortingBeta = RunLaminarGlm(SortingData, DesignMatrix);
    BetaToSort = RunLaminarGlm(Data, DesignMatrix);

    SortingBeta = SortingBeta(:, Keep);
    BetaToSort = BetaToSort(:, Keep);

    [~, Idx] = sort(SortingBeta);
    Data = Data(Idx, :);
    
    Beta = glmfit(SortingBeta, BetaToSort, 'normal');
    Beta = Beta(1);
    
    % A regression is preferred to the correlation 
    % (more appropriate if we want to do inferential statistics later)
    %
    % Old approach had correlations
    %
    %     Beta = corrcoef(SortingBeta, BetaToSort);
    %     Beta = Beta(2);

end
