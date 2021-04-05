% (C) Copyright 2021 Remi Gau

function Data = SmoothRaster(Data, Opt)

    Data = imgaussfilt(Data,  [size(Data, 1) * Opt.Raster.VerticalFWHM  .001]);

end
