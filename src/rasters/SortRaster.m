% (C) Copyright 2020 Remi Gau

function [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, Parameter)

    if ~Opt.Raster.Sort
        R = [];
        return
    end

    % If we are dealing with "group" data
    % we make loop through each subject
    % and sort with a recursive to SortRaster
    if iscell(Data) && iscell(SortingData)

        for iSub = 1:size(Data, 1)
            [Data{iSub}, SortingData{iSub}, R{iSub}] = SortRaster( ...
                                                                  Data{iSub}, ...
                                                                  SortingData{iSub}, ...
                                                                  Opt, ...
                                                                  Parameter);
        end

        return
    end

    Quad = true;
    DesignMatrix = SetDesignMatLamGlm(Opt.NbLayers, Quad);

    if ~Opt.Raster.CrossValidate

        SortingData = mean(SortingData, 3);
        Data = mean(Data, 3);

        [Data, SortingData, R] = SortThisRaster(Data, SortingData, DesignMatrix, Opt, Parameter);

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
            [DataTemp(:, :, iFold), R(iFold)] = SortThisRaster(SortedFoldsData, ...
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
        R = mean(R);

    end

end

function [Data, R] = SortThisRaster(Data, SortingData, Opt, DesignMatrix, Parameter)

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

    R = corrcoef(SortingBeta, BetaToSort);

    [~, Idx] = sort(SortingBeta);

    Data = Data(Idx, :);

    R = R(2);

end
