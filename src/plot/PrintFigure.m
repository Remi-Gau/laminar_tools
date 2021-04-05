% (C) Copyright 2021 Remi Gau

function PrintFigure(OutputDir)
    spm_mkdir(OutputDir);
    Filename = strrep(get(gcf, 'name'), ' ', '_');
    Filename = strrep(Filename, '_-_ ', '_');
    print(gcf, fullfile(OutputDir, [Filename '.tif']), '-dtiff');
    fprintf(1, 'printing:\n %s\n', fullfile(OutputDir, [Filename '.tif']));
end
