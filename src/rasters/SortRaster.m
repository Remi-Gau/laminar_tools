% (C) Copyright 2020 Remi Gau

function [Data, SortingData, R] = SortRaster(Data, SortingData, Opt, Parameter)
    
    if ~Opt.Raster.Sort
        return
    end
    
    Quad = true;
    DesignMatrix = SetDesignMatLamGlm(Opt.NbLayers, Quad);
    
    if ~Opt.Raster.CrossValidate
        
        SortingData = mean(SortingData, 3);
        Data = mean(Data, 3);

        SortingBeta = RunLaminarGlm(SortingData, DesignMatrix);
        BetaToSort = RunLaminarGlm(Data, DesignMatrix);
        
        switch lower(Parameter)
            case 'cst'
                Keep = 1;
            case 'lin'
                Keep = 2;
            case 'quad'
                Keep = 3;
        end
        
        SortingBeta = SortingBeta(:, Keep);
        BetaToSort = BetaToSort(:, Keep);

        R = corrcoef(SortingBeta, BetaToSort);
        
        [~,Idx] = sort(SortingBeta);
        
        SortingData = SortingData(Idx, :);
        Data = Data(Idx, :);
        
    end

end