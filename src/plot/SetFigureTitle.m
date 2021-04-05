% (C) Copyright 2021 Remi Gau

function Opt = SetFigureTitle(Opt)
    
    if Opt.PerformDeconvolution
        Opt.Title = [Opt.Title ' - deconvolved'];
    end
    
    if Opt.PoolIpsiContra
        Opt.Title = [Opt.Title ' pooled'];
    end
    
end