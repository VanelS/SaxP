function [cycle] = CyclePropulsion(time, signal, rotation)
    %Dans cette fonction, on identifie les differents cycles de propulsion
    %du signale lisser envoyer. Pour chaque extremite de cycle
    %nous identifions le debut et fin de cycle et l'inserons dans notre
    %variable cycle qui est retourne a la fin du programme
    A=0;
    i=2;
    seuil=-abs(mean(signal))-1;
    
    %recherche des différents point maximal (extremite) de chaque cycle de propultion
    j=1;
    while i<=length(signal)-1
        if i > rotation(j,1)&& i<rotation(j,2)
            i=i+1;
        else
            if signal(i) < signal(i-1) && signal(i) < signal(i+1) && signal(i)<seuil
               A=[A;i];
               %ici dès que l'on trouve un sommet de cycle, on parcours les
               %points suivant jusqu'à sortir du cycle pour reprendre la
               %recherche d'autre cycle
               while signal(i) < seuil && i<=length(signal)-1
                   i=i+1;
               end

            end
            i=i+1;
            if j<length(rotation) && i > rotation(j,2)
                j=j+1;
            end
        end
    end
    hold on
    
%     plot(time,signal)
   
    cycle=zeros(length(A)-2,2);
    
    for j=2:length(A)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
%         %calcule des différentes tangente à différents points 
%         pts=(signal(A(j)+1)-signal(A(j)))/(time(A(j)+1)-time(A(j)));
%         bs=-(time(A(j))*pts - signal(A(j)));
%         
%         %affichage des tangentes
%         plot(time((A(j)-50):(A(j)+50)),pts*time((A(j)-50):(A(j)+50))+ bs,'g','linewidth',2)
        
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
        
        cycle(j-1,1)= xarr;
        cycle(j-1,2)= xavc;
    
    end
end