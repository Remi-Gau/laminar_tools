% (C) Copyright 2021 Remi Gau

function Data = GenerateGroupSurfaceDataRaster(Opt)
    %
    % generate data to be used for raster plotting
    %

    for iSubject = 1:Opt.NbSubject

        Data{iSubject, 1} = GenerateSubjectSurfaceDataRaster(Opt, iSubject); %#ok<AGROW>

    end

end
