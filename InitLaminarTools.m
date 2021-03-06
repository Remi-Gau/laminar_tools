% (C) Copyright 2020 Remi Gau

function InitLaminarTools()
    % InitLaminarTools()
    %
    % 1 - Check if version requirements
    % are satisfied and the packages are
    % are installed/loaded:
    %   Octave > 4
    %       - image
    %       - statistics
    %
    %   MATLAB >= R2017a
    %
    % 2 - Add project to the O/M path

    %
    matlabVersion = '9.2.0';

    % required package list
    octaveVersion = '4.0.3';
    installlist = {'io', 'statistics', 'image'};

    if IsOctave()

        % Exit if min version is not satisfied
        if ~compare_versions(OCTAVE_VERSION, octaveVersion, '>=')
            error('Minimum required Octave version: %s', octaveVersion);
        end

        for ii = 1:length(installlist)

            packageName = installlist{ii};

            try
                % Try loading Octave packages
                disp(['loading ' packageName]);
                pkg('load', packageName);

            catch
                TryInstallFromForge(packageName);
            end
        end

    else % MATLAB ----------------------------

        if verLessThan('matlab', matlabVersion)
            error('Sorry, minimum required version is R2017b. :(');
        end

    end

    % If external dir is empty throw an exception
    % and ask user to update submodules.
    AddDependencies();

    disp('Correct matlab/octave verions and added to the path!');

end

%%
%% Return: true if the environment is Octave.
%%
function retval = IsOctave
    persistent cacheval   % speeds up repeated calls

    if isempty (cacheval)
        cacheval = (exist ("OCTAVE_VERSION", "builtin") > 0);
    end

    retval = cacheval;
end

function TryInstallFromForge(packageName)

    errorcount = 1;
    while errorcount % Attempt twice in case installation fails
        try
            pkg('install', '-forge', packageName);
            pkg('load', packageName);
            errorcount = 0;
        catch err
            errorcount = errorcount + 1;
            if errorcount > 2
                error(err.message);
            end
        end
    end

end

function AddDependencies()

    pth = fileparts(mfilename('fullpath'));

    % TODO make a cleaner import of the lib folder
    addpath(genpath(fullfile(pth, 'lib')));
    addpath(genpath(fullfile(pth, 'src')));

end
