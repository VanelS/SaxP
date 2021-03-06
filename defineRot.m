function [rot]=defineRot(G,gyroCycle)
    %define rot va prendre les points maximale du signal dans les intervalles 
    %rotation contenue dans gyroCycle. Puis a partir de ces points on
    %parcoure le signal jusqu'a depasser l'axe Y=0 de pars et d'autre des
    %points. Et on les retournent par la variable rot qui contient juste
    %les indices de fin et d�but de cycles.
    
    indice=[];
    maxi=-100;
    for i=1:length(gyroCycle)
        for j=gyroCycle(i,1):gyroCycle(i,2)
            if maxi<=G(j)
                maxi=G(j);
                t=j;
            end
        end
        indice=[indice,t];
        maxi=-100;
    end
    
    rot=zeros(length(indice),2);
    for j=1:length(indice)
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;

        %recherche du d�but de cycle 
        while (indice(j)-arr)>0 && xarr==-1
            if G(indice(j)-arr)<=0
                xarr=indice(j)-arr;
            end
            arr=arr+1;
        end
        
        %recherche de fin de cycle
        while (indice(j)+avc)<length(G) && xavc==-1
            if G(indice(j)+avc)<=0
                xavc=indice(j)+avc;
            end
            avc=avc+1;
        end 
        
        %sauvegarde des points de fin et d�but de cycle
        rot(j,1)= xarr;
        rot(j,2)= xavc;
    end
    
end