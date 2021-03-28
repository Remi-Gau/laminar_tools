% (C) Copyright 2020 Remi Gau

function DesignMatrix = SetDesignMatLamGlm(NbLayers, Quad)
    %
    % Creates a design matrix for the laminar GLM. The regressors are orthogonalized
    % with respect to the first regressor (that of the constant).
    %
    % USAGE::
    %
    %   DesignMatrix = SetDesignMatLamGlm(NbLayers [, Quad == true])
    %
    % :param NbLayers: number of layers in the model
    % :type NbLayers: positive integer
    % :param Quad: Indicates if a quadratic component should be included in the
    %              model.
    % :type Quad: boolean
    %
    % :returns:
    %           :DesignMatrix: (array) design matrix with dimension (NbLayers x m)
    %

    if nargin < 1 || isempty(NbLayers)
        NbLayers = 6;
    end

    if nargin < 2
        Quad = true;
    end

    DesignMatrix = (1:NbLayers) - mean(1:NbLayers);

    if ~Quad
        DesignMatrix = [ones(NbLayers, 1) DesignMatrix'];
    else
        DesignMatrix = [ones(NbLayers, 1) DesignMatrix' (DesignMatrix.^2)'];
    end

    DesignMatrix = orthogonalise(DesignMatrix);

end

function X = orthogonalise(X, OPT)
    % Recursive Gram-Schmidt orthogonalisation of basis functions
    % FORMAT X = orthogonalise(X,OPT)
    %
    % X   - matrix
    % OPT - 'norm' for Euclidean normalisation
    %     - 'pad'  for zero padding of null space [default]
    %
    % Serial orthogonalisation starting with the first column

    % taken from spm_orth from SPM

    % Reference:
    % Golub, Gene H. & Van Loan, Charles F. (1996), Matrix Computations (3rd
    % ed.), Johns Hopkins, ISBN 978-0-8018-5414-9.
    % __________________________________________________________________________
    % Copyright (C) 2002-2012 Wellcome Trust Centre for Neuroimaging

    % Karl Friston
    % $Id: spm_orth.m 5821 2013-12-31 14:26:41Z karl $

    % -Default
    % --------------------------------------------------------------------------
    try
        OPT;
    catch
        OPT = 'pad';
    end

    % -Recursive Gram-Schmidt orthogonalisation
    % --------------------------------------------------------------------------
    sw    = warning('off', 'all');
    [n, m] = size(X);
    X     = X(:, any(X));
    rankX = rank(full(X));
    try
        x     = X(:, 1);
        j     = 1;
        for i = 2:size(X, 2)
            D = X(:, i);
            D = D - x * (pinv(x) * D);
            if norm(D, 1) > exp(-32)
                x          = [x D];
                j(end + 1) = i;
            end
            if numel(j) == rankX
                break
            end
        end
    catch
        x     = zeros(n, 0);
        j     = [];
    end
    warning(sw);

    % and normalisation, if requested
    % --------------------------------------------------------------------------
    switch OPT
        case {'pad'}
            X      = zeros(n, m);
            X(:, j) = x;
        case {'norm'}
            X      = spm_en(x);
        otherwise
            X      = x;
    end

end
