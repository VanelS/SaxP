function [interv] = gyroCycles(X,signal)
    %gyroCycles est une fonction permettant d'obtenir les intevales de
    %rotation sans avoir besoin de seuil. Dans un premier temps le
    %programme transforme les valeurs du signal filtrer(Y) en leurs valeurs 
    %absolue, puis elle tri celles-ci dans l'ordre croissant. Comme le 
    %nombre de point culminant represent 1/8 du signal alors, apres le tri, 
    %on garde la deuxieme moitie du signal. Ensuite, nous identifions le 
    %troisieme quartile et gardons en memoire dans res, les valeurs de 
    %l'intervalle troisieme quartile jusqu'à la taille du tableau du signal  
    %trie. On prend la valeur la plus grande de notre variable res, puis on
    %determine ça position dans le signal filtrer Y et on determine un
    %intervalle à partir de ce point sur Y. Si les points selectionnes sont
    %compris dans la res, alors on les supprime dans res et on leurs
    %affecte la valeur de -1 pour evitier de retomber dessus pour le
    %prochain maximum de res. On repete la meme procedure de
    %l'indentification du maximum jusqu'a ca suppression. Enfin, les
    %valeurs maximum mise en memoire sont envoyer dans la fonction
    %intervale qui va nous retourner les intervales de ces extremums sur le
    %signal non filtrer.
    
    %lisse le signal d'origine et on le garde en memoire dans Y
    Y=filtfilt(ones(60,1),60,signal(1:length(signal)));
    %on applique la valeur absolue dans sur le signale filtre
    Y=abs(Y);
    %on le trie et le garde en memoire dans Ysort
    Ysort=sort(Y);
    taille=length(Ysort);
    %on ne garde que la moitie dans Ysort du signale filtre et trie
    Ysort=Ysort(ceil(taille/2):taille);
    taille=length(Ysort);
    Q3=ceil(3*taille/4);
    %on prend la partie troisieme quartile jusqu'a la fin de Ysort dans res
    res=Ysort(Q3+1:taille); 
    s=1;
    Points=[];
    
    %ici on boucle jusqu'a ne plus avoir de donne dans res et par securite 
    %on ne boucle que 500 fois    
    while s<=500 && ~isempty(res)
        %on identifie le maximum de res puis on identifie sa position dans
        %le signal Y. Et on garde en memoire cette position.
        maxi=max(res);
        pos=position(1,Y,maxi);
        Points=[Points,pos];
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %On idientifie l'intervale de debut et de fin en partant de la
        %position du maximum. On considere le point de debut et de fin
        %comme etant le premier point que l'on trouve lorsque l'on depasse
        %0.01 a gauche et a droite du point culminant sur le signal Y.        
        while (pos-arr)>0 && (xarr==-1 )
            if Y(pos-arr)<=0.01 && xarr==-1
                xarr=pos-arr;
            end
            arr=arr+1;
        end
        
        while(pos+avc)<length(X) && xavc==-1
            if Y(pos+avc)<=0.01 
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
        
        %on regarde si les points de l'intervalles trouver precedemment
        %sont compris dans la variable res. Si c'est le cas, on supprime
        %les points identiques dans res et on met à -1 dans Y.
        for i=xarr:xavc
            if ismember(Y(i),res)
                res(position(1,res,Y(i)))=[];
                Y(i)=-1;
            end
        end
        s=s+1;
    end
    interv=intervale(Points,signal);
end