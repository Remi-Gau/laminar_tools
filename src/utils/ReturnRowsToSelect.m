% (C) Copyright 2021 Remi Gau

function RowsToSelect = ReturnRowsToSelect(Criteria)
%
    % Examples::
    %
    %   RowsToSelect = ReturnRowsToSelect({ConditionVec, ConditionToReturn});
    %
    %   RowsToSelect = ReturnRowsToSelect( {ConditionVec, ConditionToReturn;
    %                                       RunVec,       RunToReturn      } );
    %
    
    RowsToSelect = [];

    for iCriteria = 1:size(Criteria, 1)

        VertVect = Criteria{iCriteria, 1};
        VertVect = ReturnVerticalVector(VertVect);

        RowsToSelect = [RowsToSelect VertVect == Criteria{iCriteria, 2}]; %#ok<*AGROW>
    end

    RowsToSelect = all(RowsToSelect, 2);

end
