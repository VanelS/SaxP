function [interv] = roueCycles(X,signal)
    y=filtfilt(ones(60,1),60,signal(1:length(signal)));
    tab=[X,y];
    Ysort=sortrows(tab,2);
    taille=length(tab(:,2));
    Q3=ceil(3*taille/4);
    res=Ysort(Q3:taille,:); 
    s=1;
    Points=[];
    
    while s<=500 && ~isempty(res)
        %on identifie le maximum de res puis on identifie sa position dans
        %le signal tab. Et on garde en memoire cette position.
        maxi=max(res(:,2));
        pos=position(1,tab(:,2),maxi);
        Points=[Points,pos];
        
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        
        %On idientifie l'intervale de debut et de fin en partant de la
        %position du maximum. On considere le point de debut et de fin
        %comme etant le premier point que l'on trouve lorsque l'on depasse
        %zero a gauche et a droite du point culminant sur le signal. 
        while (pos-arr)>0 && xarr==-1
            if tab(pos-arr,2)<=0 && xarr==-1
                xarr=pos-arr;
            else
                arr=arr+1;
            end
        end
        while (pos+avc)<length(X)&& xavc==-1
            if tab(pos+avc,2)<=0
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
        
        for i=xarr:xavc

            if ismember(tab(i,1),res(:,1))

                res(position(1,res(:,1),tab(i,1)),:)=[];
                tab(i,2)=-1;
            end
        end
        if res(position(1,res(:,2),maxi),2)==maxi
            res(position(1,res(:,2),maxi),:)=[];
        end
        s=s+1;
    end
    
    interv=intervale(Points,signal);
end