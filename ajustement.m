function [rot] = ajustement(Y,rotation)
    %cette fonction est comme sont noms l'indique une fonction d'ajustement
    %C'est-a-dire que lorsque nous identifions les cycles de rotation, les
    %debuts et fins de ces intervalles de temps peuvent au sommet d'un
    %pique positif ou negatif. De ce fait nous les remettons au niveau zero
    %sur l'axe des ordonnees.
    
    rot=rotation;
    for j=1:length(rotation)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
      
        while (rotation(j,1)-arr)>0 && (xarr==-1 ||xavc==-1)
            if Y(rotation(j,1)-arr)<=0 && xarr==-1
                xarr=rotation(j,1)-arr;
            end
            if Y(rotation(j,2)-avc)>=0 && xavc==-1
                xavc=rotation(j,2)-avc;
            end
            avc=avc+1;
            arr=arr+1;
        end
        rot(j,1)=xarr;
        rot(j,2)=xavc;
    end
end