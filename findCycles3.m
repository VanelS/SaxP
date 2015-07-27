function [gyroCycles]=findCycles3(X,Y)
    %Cette fonction est principalement utilise pour trouver les cycles de
    %rotation avec le signale du gyroscope. Pour chaque extremite de cycle
    %nous identifions le debut et fin de cycle et l'inserons dans notre
    %variable gyroCycle qui est retourne a la fin du programme
    
    i=2;
    seuil=0.8;
    gyroCycles=[];

    while i<=length(Y)-1
        if i==44280
            disp(Y(i) < Y(i-1) && Y(i) < Y(i+1) && Y(i)<-0.8)
        end
        if Y(i) < Y(i-1) && Y(i) < Y(i+1) && Y(i)<-0.8
            
            arr=1;
            xarr=-1;
            xavc=-1;
            %recherche de debut de cycle
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

        if Y(i) > Y(i-1) && Y(i) > Y(i+1) && Y(i)>0.8
            
            arr=1;
            xarr=-1;
            xavc=-1;
            %recherche de debut de cycle
            while (i-arr)>0 && xarr==-1
                if Y(i-arr)<=0 
                    xarr=i-arr;
                end
                arr=arr+1;
            end

            %recherche de fin de cycle
            while i<length(X) && xavc==-1
                if Y(i)<=0
                    xavc=i;
                end
                i=i+1;
            end 
            gyroCycles=[gyroCycles;[xarr,i-1]];
        end
        
        i=i+1;
    end
    
end