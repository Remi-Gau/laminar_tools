% (C) Copyright 2020 Remi Gau

function t = PrintPValue(P, Xpos, Ypos, Opt)

    t = [];
    
    if Opt.PlotPValue

        for iP = 1:numel(P)

            Sig = [];
            if P(iP) < 0.001
                Sig = sprintf('p<0.001 ');
            else
                Sig = sprintf('p=%.3f ', P(iP));
            end

            t = text( ...
                     Xpos(iP) - .2, ...
                     Ypos, ...
                     sprintf(Sig));
            set(t, 'fontsize', Opt.Fontsize - 2);

            if P(iP) < Opt.Alpha
                set(t, ...
                    'color', 'k', ...
                    'fontweight', 'bold', ...
                    'fontsize', Opt.Fontsize - 2);
            end

        end

    end
end
