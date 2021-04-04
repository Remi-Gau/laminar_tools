% (C) Copyright 2021 Remi Gau

function MAX = GetAbsMax(Data)

    if iscell(Data)
        tmp = cellfun(@(x) abs(max(x(:))), Data);
        MAX = max(tmp(:));
    else
        MAX = max(abs(Data(:)));
    end

end
