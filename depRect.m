function [Dep] = depRect(cycle,listRot)
    %depacement rectiligne
    Dep=[];
    for i=1:length(listRot)
        if i==1
            Dep=[Dep;[cycle*1000 listRot(i,1)-1]];
        else

            Dep=[Dep;[listRot(i-1,2)+1 listRot(i,1)-1]];
        end
    end

end