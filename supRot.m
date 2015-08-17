function [Cycles] = supRot(listCycle,listRot)
    % Cette fonction suprime les cycles compris dans la periode de
    % rotation. Elle prend en parametre la liste des cycles de propulsion
    % et de rotation puis renvoie la liste de cycles de propulsion sans les
    % cycles compris dans la rotation. Si le debut du cycle est inferieur  
    % au debut du cycle de rotation ou qu'il est superieur a la fin du 
    % cycle de rotation.
    

    Cycles=[];
    j=1;
    
    %pour chaque cycles Si le debut du cycle est inferieur au debut du 
    %cycle de rotation ou qu'il est superieur a la fin du cycle de
    %rotation.
    for i=1:length(listCycle)
        if listCycle(i)<=listRot(j,1) || listCycle(i)>=listRot(j,2)
            Cycles=[Cycles;listCycle(i)];
        end
        
        %Si j est inferieur a la taille de la liste de rotation et que le
        %cycle courant est superieur au cycle de rotation(j), alors on
        %passe au cycle de rotation suivant (j+1)
        if j<length(listRot) && listCycle(i)>=listRot(j,2)
            j=j+1;
        end
    end
end