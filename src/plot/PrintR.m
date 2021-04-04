% (C) Copyright 2020 Remi Gau

function PrintR(R, Opt)
    
    if Opt.Raster.PlotRValue
        
        if iscell(R)
            R = cell2mat(R)';
        end
        
        CentralTendency = mean(R);
        Error = ComputeDispersionIndex(R, Opt);
        
        P = ComputePValue(R, Opt, Opt.Specific{1}.Ttest);
        
        R = sprintf('R=%.2f +/- %.2f\np=%.3f', CentralTendency, Error, P);
        
        ax = gca;
        
        Xpos = ax.XLim(2) - 0.08 * diff(ax.XLim);
        Ypos = ax.YLim(1) - 0.06 * diff(ax.YLim);
        t1 = text( ...
            Xpos, ...
            Ypos, ...
            sprintf(R));
        set(t1, 'fontsize', Opt.Fontsize-2, ...
            'HorizontalAlignment', 'Center');
        
    end
    
end
