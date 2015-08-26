function [Points] = roueCycles(X,signal,quartile)
    %Cette fonction permet de detecter les cycles du signal envoyer en
    %parametre. Dans un premier temps, on lisse le signal et l'inserrons
    %dans un tableau tab avec la variable X passer en parametre. Ensuite
    %nous trions le tableau par ligne en prenant en reference la colonne du
    %signal. Et nous sauvegardons la partie du troisieme quartile jusqu'a
    %la fin du tableau dans la variable res. Puis, nous prenons le point
    %maximal du tableau res et nous determinons sa position dans tab. A
    %partir de la nous indentifions les intervales debut et fin à partir du
    %point maximal. Nous verifions que les points de cette intervale sont
    %dans res grace a leur valeurs correspondante X. Si c'est le cas nous
    %effacons la ligne correspondant dans res et nous mettons à -1 la
    %partie Y de tab. S'il n'y a pas de correspondance nous supprimons le 
    %point maximale du tableau res. 
    
    
    %creation du tableau contenant X et le signale lisser
    tab=[X,signal];
    Ysort=sortrows(tab,2);
    taille=length(tab(:,2));
    
    Q3=ceil(quartile*taille/4);
     
    %sauvegarde dans res de la partie superieur du 3eme quartile
    res=Ysort(Q3:taille,:);
    s=1;
    Points=[];
    
    while s<=500 && ~isempty(res)
        %on identifie le maximum de res puis on identifie sa position dans
        %le signal tab. Et on garde en memoire cette position.
        maxi=res(length(res(:,1)),1);
        pos=position(1,tab(:,1),maxi);
        %on sauvegarde la position du maxi
        Points=[Points;pos];
        
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %On idientifie l'intervale de debut et de fin en partant de la
        %position du maximum. On considere le point de debut et de fin
        %comme etant le premier point que l'on trouve lorsque l'on depasse
        %zero a gauche et a droite du point culminant sur le signal. 
        while (pos-arr)>0 && xarr==-1
            tangente=(tab(pos-arr+1,2)-tab(pos-arr,2))/(tab(pos-arr+1,1)-tab(pos-arr,1));
            if tangente<=0 && tab(pos-arr,2)<=0 && xarr==-1
                xarr=pos-arr;
            end
            arr=arr+1;
        end

        while (pos+avc)<length(X)&& xavc==-1
            tangente=(tab(pos+avc+1,2)-tab(pos+avc,2))/(tab(pos+avc+1,1)-tab(pos+avc,1));
            if tangente>=0 && tab(pos+avc,2)<=0 && xavc==-1
                xavc=pos+avc;
            end
            avc=avc+1;
        end
        
        %Dans le cas ou le sommet est au debut du signal et que lors
        %du parcours ce signal on ne depasse pas les zeros alors on
        %met le point 1 comme etant le point de debut de l'interval
        if xarr<=0
            xarr=1;
        end
        
        %De meme ici, mais dans l'autre sens, si le sommet est 
        %proche de la fin et que lors du parcours du signal on depasse
        %pas les zeros, on met le dernier point du signal comme
        %etant le point de fin de l'interval
        if xavc<=0
            xavc=length(X);
        end
        
        %A partir de l'interval calculer, nous verifions que le point au
        %coordonnee du point X est present dans res, si c'est le cas nous
        %le supprimons de res et le mettons à -1 dans le tableau tab
        for i=xarr:xavc
            if ismember(tab(i,1),res(:,1))
                res(position(1,res(:,1),tab(i,1)),:)=[];
                tab(i,2)=-1;
            end
        end
%         %Si le point n'a pas etait identifier nous le supprimons dans res.
%         if res(position(1,res(:,2),maxi),2)==maxi
%             res(position(1,res(:,2),maxi),:)=[];
%         end
        s=s+1;
    end
end