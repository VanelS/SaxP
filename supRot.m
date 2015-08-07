function [cycles] = supRot(listCycle,listRot)
    listCycle=sort(listCycle);
    listRot=sort(listRot);
    cycles=[];
    j=1;
    for i=1:length(listCycle)
        if listCycle(i,2)<=listRot(j,1) || listCycle(i,1)>=listRot(j,2)
            cycles=[cycles;listCycle(i,:)];
        end
        if j<length(listRot) && listCycle(i,1)>=listRot(j,2)
            j=j+1;
        end
    end
        
end