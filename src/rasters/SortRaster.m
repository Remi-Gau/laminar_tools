% (C) Copyright 2020 Remi Gau

function [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, Parameter)

    if ~Opt.Raster.Sort
        R = [];
        return
    end

    Quad = true;
    DesignMatrix = SetDesignMatLamGlm(Opt.NbLayers, Quad);

    switch lower(Parameter)
        case 'cst'
            Keep = 1;
        case 'lin'
            Keep = 2;
        case 'quad'
            Keep = 3;
    end

    if ~Opt.Raster.CrossValidate

        SortingData = mean(SortingData, 3);
        Data = mean(Data, 3);

        [Data, SortingData, R] = Sort(Data, SortingData, DesignMatrix, Keep);

    else

        NbRuns = size(Data, 3);

        for iFold = 1:NbRuns

            SortingFold = false(NbRuns, 1);
            SortingFold(iFold) = true;

            SortedFolds = true(NbRuns, 1);
            SortedFolds(iFold) = false;

            SortingFoldData = SortingData(:, :, SortingFold);
            SortedFoldsData = mean(Data(:, :, SortedFolds), 3);

            [DataTemp(:, :, iFold), SortingDataTemp(:, :, iFold), R(iFold)] = Sort(SortedFoldsData, ...
                                                                                   SortingFoldData, ...
                                                                                   DesignMatrix, ...
                                                                                   Keep); %#ok<*AGROW>

        end

        SortingData = mean(SortingDataTemp, 3);
        Data = mean(DataTemp, 3);
        R = mean(R);

    end

end

function [Data, SortingData, R] = Sort(Data, SortingData, DesignMatrix, Keep)

    SortingBeta = RunLaminarGlm(SortingData, DesignMatrix);
    BetaToSort = RunLaminarGlm(Data, DesignMatrix);

    SortingBeta = SortingBeta(:, Keep);
    BetaToSort = BetaToSort(:, Keep);

    R = corrcoef(SortingBeta, BetaToSort);

    [~, Idx] = sort(SortingBeta);

    SortingData = SortingData(Idx, :);
    Data = Data(Idx, :);

    R = R(2);

end
