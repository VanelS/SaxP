function [] =coupeCycle(X, Y, chemin, fichier, indTemps,seuil)

    A=0;
    i=2;
    
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
   
    cycle=zeros(length(A)-2,2);
    rot=[0,0];
    for j=2:length(A)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %calcule des différentes tangente à différents points 
        pts=(Y(A(j)+1)-Y(A(j)))/(X(A(j)+1)-X(A(j)));
        bs=-(X(A(j))*pts - Y(A(j)));
        
        %affichage des tangentes
        plot(X((A(j)-50):(A(j)+50)),pts*X((A(j)-50):(A(j)+50))+ bs,'g','linewidth',2)
        
        %recherche du début de cycle 
        while (A(j)-arr)>0 && xarr==-1
            if (Y(A(j)-arr+1)-Y(A(j)-arr))/(X(A(j)-arr+1)-X(A(j)-arr))>=0 && Y(A(j)-arr)>-2
                xarr=X(A(j)-arr);
                
                if j>2 && xarr - cycle(j-2,2) > 1.5  
                   rot=[rot;[cycle(j-2,2),xarr]];
                end
            end
            arr=arr+1;
        end
        %recherche de fin de cycle
        while (A(j)+avc)<length(X) && xavc==-1
            if (Y(A(j)+avc +1)-Y(A(j)+avc))/(X(A(j)+avc+1)-X(A(j)+avc))<=0 && Y(A(j)+avc)>-2
                xavc=X(A(j)+avc);
               
            end
            avc=avc+1;
        end 
        %sauvegarde des points de fin et début de cycle
        
        cycle(j-1,1)= xarr;
        cycle(j-1,2)= xavc;
%         scatter(xarr,Y(A(j)-(arr-1)),25,'filled');
%         scatter(xavc,Y(A(j)+(avc-1)),25,'filled');
    
    end
  
    hold off
	rot=rot(2:length(rot),1:2);
    
    decoupeCycle(cycle, rot , chemin, fichier, indTemps);
    fichVide(chemin, [fichier 'decoupe']);
    
    cycleComplet(cycle, rot , chemin, fichier, indTemps);
    fichVide(chemin, [fichier 'Cycle Complet']);
    
end