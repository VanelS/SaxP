function [gyroCycles]=findCycles2(X,Y)

    i=2;
    seuil=-0.8;
    gyroCycles=[];
    
    while i<=length(Y)-1
        
        if Y(i) < Y(i-1) && Y(i) < Y(i+1) && Y(i)<seuil
            arr=1;
            xarr=-1;
            xavc=-1;
            while (i-arr)>0 && xarr==-1
                if Y(i-arr)>=0 
                    xarr=i-arr;
                end
                arr=arr+1;
            end

                %recherche de fin de cycle
            while i<length(X) && xavc==-1
                if Y(i)>=0
                    xavc=i;
                end
                i=i+1;
            end 
            gyroCycles=[gyroCycles;[xarr,i-1]];
        end

        
        i=i+1;
    end
    
end