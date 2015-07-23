function [rot] = ajustement(Y,rotation)
    rot=rotation;
    for j=1:length(rotation)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %recherche du début de cycle 
        while (rotation(j,1)-arr)>0 && xarr==-1
            if Y(rotation(j,1)-arr)<=0
                xarr=rotation(j,1)-arr;
            end
            arr=arr+1;
        end
        rot(j,1)=xarr;
        
        while (rotation(j,2)+avc)<=length(Y) && xavc==-1
            if Y(rotation(j,2)-avc)>=0
                xavc=rotation(j,2)-avc;
            end
            avc=avc+1;
        end
        rot(j,2)=xavc;
    end
end