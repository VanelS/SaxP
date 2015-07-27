function [gyroCycles]=findCycles(X,Y)
    %Cette fonction est principalement utilise pour trouver les cycles de
    %rotation avec le signale du gyroscope. Pour chaque extremite de cycle
    %nous identifions le debut et fin de cycle et l'inserons dans notre
    %variable gyroCycle qui est retourne a la fin du programme.

    A=0;
    i=2;
    seuil=-0.8;

    %recherche des différents point maximal de chaque cycle de propultion
    while i<=length(Y)-1
        if Y(i) < Y(i-1) && Y(i) < Y(i+1) && Y(i)<seuil

           A=[A;i];
           %ici dès que l'on trouve un sommet de cycle, on parcours les
           %points suivant jusqu'à sortir du cycle pour reprendre la
           %recherche d'autre cycle
           while Y(i) < seuil && i<=length(Y)-1
               i=i+1;
           end

        end
        i=i+1;
    end
    hold on

    %     plot(X,Y)

    gyroCycles=zeros(length(A)-2,2);

    for j=2:length(A)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;

        %recherche du début de cycle 
        while (A(j)-arr)>0 && xarr==-1
            if (Y(A(j)-arr+1)-Y(A(j)-arr))/(X(A(j)-arr+1)-X(A(j)-arr))>=0 && Y(A(j)-arr)>-1
                xarr=A(j)-arr;
            end
            arr=arr+1;
        end
        
        %recherche de fin de cycle
        while (A(j)+avc)<length(X) && xavc==-1
            if (Y(A(j)+avc +1)-Y(A(j)+avc))/(X(A(j)+avc+1)-X(A(j)+avc))<=0 && Y(A(j)+avc)>-1
                xavc=A(j)+avc;

            end
            avc=avc+1;
        end 
        
        %sauvegarde des points de fin et début de cycle

        gyroCycles(j-1,1)= xarr;
        gyroCycles(j-1,2)= xavc;
    %         scatter(xarr,Y(A(j)-(arr-1)),25,'filled');
    %         scatter(xavc,Y(A(j)+(avc-1)),25,'filled');

    end
end