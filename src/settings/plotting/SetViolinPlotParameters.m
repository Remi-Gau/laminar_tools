% (C) Copyright 2020 Remi Gau

function [ViolinPlotParameters, MeanDispersion] = SetViolinPlotParameters()

    ViolinPlotParameters = GetViolinPlotDefautls();

    MeanDispersion = GetMeanDispersionDefaults();

end


function ViolinPlotParameters = GetViolinPlotDefautls()
    
    ViolinPlotParameters.ShowMeanMedian = 0;
    ViolinPlotParameters.GlobalNorm = 2;
    
    ViolinPlotParameters.Marker = 'o';
    ViolinPlotParameters.MarkerSize = 7;
    ViolinPlotParameters.MarkerEdgeColor = 'k';
    ViolinPlotParameters.MarkerFaceColor = 'w';
    
    ViolinPlotParameters.LineWidth = 2;
    ViolinPlotParameters.BinWidth = 1;
    ViolinPlotParameters.SpreadWidth = 0.8;
    
    ViolinPlotParameters.Margin = 4.5;
    
    ViolinPlotParameters.DistWidth = 0.7;
    
end

function MeanDispersion = GetMeanDispersionDefaults()
    
    MeanDispersion.LineWidth = 1;
    MeanDispersion.Marker = 'o';
    MeanDispersion.MarkerSize = 5;
    
end