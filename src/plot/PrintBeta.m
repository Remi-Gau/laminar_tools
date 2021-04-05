% (C) Copyright 2020 Remi Gau

function PrintBeta(Beta, Opt)

    if Opt.Raster.PlotRValue

        if iscell(Beta)
            Beta = cell2mat(Beta)';
        end

        CentralTendency = mean(Beta);
        Error = ComputeDispersionIndex(Beta, Opt);

        P = ComputePValue(Beta, Opt, Opt.Specific{1}.Ttest);

        Beta = sprintf('beta=%.2f +/- %.2f\np=%.3f', CentralTendency, Error, P);

        ax = gca;

        Xpos = ax.XLim(2) - 0.08 * diff(ax.XLim);
        Ypos = ax.YLim(1) - 0.06 * diff(ax.YLim);
        t1 = text( ...
                  Xpos, ...
                  Ypos, ...
                  sprintf(Beta));
        set(t1, 'fontsize', Opt.Fontsize - 2, ...
            'HorizontalAlignment', 'Center');

    end

end
