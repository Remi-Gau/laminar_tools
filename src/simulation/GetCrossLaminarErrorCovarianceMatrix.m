% (C) Copyright 2021 Remi Gau

function Sigma = GetCrossLaminarErrorCovarianceMatrix(Opt)

    if ~Opt.IID && Opt.NbLayers == 6

        % TODO
        % - find more compact way to express and generate this covariance matrix

        % covariance matrix to generate data: taken from real data
        Sigma = [ ...
                 2.6485    1.9059    1.0569    0.5610    0.3431    0.3011; ...
                 1.9059    2.6827    2.1034    1.1775    0.5344    0.3486; ...
                 1.0569    2.1034    2.8142    2.2895    1.1996    0.5430; ...
                 0.5610    1.1775    2.2895    2.9694    2.3133    1.1270; ...
                 0.3431    0.5344    1.1996    2.3133    2.9294    2.1847; ...
                 0.3011    0.3486    0.5430    1.1270    2.1847    3.0297];

    else
        Sigma = eye(Opt.NbLayers);

    end
end
