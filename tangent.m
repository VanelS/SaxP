function [cycle] = tangent(time,signal,A,rotation)
    plot(time,signal)
    cycle=[];
    for j=1:length(A)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %calcule des différentes tangente à différents points 
        pts=(signal(A(j)+1)-signal(A(j)))/(time(A(j)+1)-time(A(j)));
        bs=-(time(A(j))*pts - signal(A(j)));
        %affichage des tangentes
        hold on
        plot(time((A(j)-50):(A(j)+50)),pts*time((A(j)-50):(A(j)+50))+ bs,'g','linewidth',2)
        hold off
        
        %recherche du début de cycle 
        i=1;
        while (A(j)-arr)>0 && xarr==-1
            tangente=(signal(A(j)-arr+1)-signal(A(j)-arr))/(time(A(j)-arr+1)-time(A(j)-arr));
            if (tangente>=0 && signal(A(j)-arr) > -2) || (A(j)-arr) == rotation(i , 2)
                xarr=time(A(j)-arr);
            end
            arr=arr+1;
            if i<length(rotation) && (A(j)-arr)>(rotation(i , 2) + rotation(i + 1 , 1))/2
                i=i+1;
            end
        end
        %recherche de fin de cycle
        i=1;
        while (A(j)+avc)<length(time) && xavc==-1
            tangente = (signal(A(j)+avc +1)-signal(A(j)+avc))/(time(A(j)+avc+1)-time(A(j)+avc));
            if tangente<=0 && signal(A(j)+avc)>-2 || (A(j)+avc) == rotation(i , 1)
                xavc=time(A(j)+avc);
               
            end
            avc=avc+1;
            if i<length(rotation) && (A(j)+avc)>(rotation(i , 2) + rotation(i + 1 , 1))/2
                i=i+1;
            end
        end 
        %sauvegarde des points de fin et début de cycle
        
        cycle(j,1)= xarr;
        cycle(j,2)= xavc;
    
    end

end