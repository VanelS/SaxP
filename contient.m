function [bool] = contient(list,val)
    for i=1:length(list)
        if list(i)== val
            bool=true;
            break
        end
    end
    bool=false;
end