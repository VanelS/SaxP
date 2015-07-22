function [rot] = ajustement(Y,rotation)
    for j=1:length(rotation)
        arr=1;
        xarr=-1;
        rot=rotation;
        %recherche du début de cycle 
        while (rotation(j,1)-arr)>0 && xarr==-1
            if Y(rotation(j,1)-arr)<=0
                xarr=rotation(j,1)-arr;
            end
            arr=arr+1;
        end
        rot(j,1)=xarr;
    end


end