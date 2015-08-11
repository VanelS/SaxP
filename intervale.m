function [interv] = intervale(list,signal)
    %Cette fonction intervale permet de renvoyer un intervalle ou une liste
    %d'intervalle (en position) sur un signal et une liste de sommmets ou 
    %un seul sommet donné en paramètre. L'algorithme developper ici se 
    %decompose en deux parties, le if et le else. Dans le if, on traite le 
    %cas ou nous avons qu'un seul sommet a traité. Dans le else, on traite 
    %le cas ou nous avons plusieurs sommets. 
    
    siz=size(list);
    interv=[];
    
    % La taille de la liste nous permet de savoir s'il faut traite un
    % sommet ou plusieurs.
    if siz(1,1)==1 && siz(1,2)==1 
        %Si le point est positif on parcour de chaque cote du sommet
        %jusqu'a passer en-dessous de la barre des zeros. Sinon on fait la
        %meme chose mais en passant au-dessus de la barre des zeros.
        if list > 0
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;

            while (list-arr)>0 &&(xarr==-1)
                if signal(list-arr)<=0 && xarr==-1
                    xarr=list-arr;
                end
                
                arr=arr+1;
            end
            while (list+avc)<=length(signal) &&  xavc==-1
                if signal(list+avc)<=0 && xavc==-1
                    xavc=list+avc;
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
            %proche de la fin et lors du parcours du signal on depasse
            %pas les zeros, on met le dernier point du signal comme
            %etant le point de fin de l'interval
            if xavc<=0
                xavc=length(signal);
            end
            %on sauvegarde les intervales dans interv.
            interv(1,1)=xarr;
            interv(1,2)=xavc;
            
        else
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;

            while (list-arr)>0 && (xarr==-1)
                if signal(list-arr)>=0 && xarr==-1
                    xarr=list-arr;
                end
                arr=arr+1;
            end
            while (list+avc)<=length(signal) && xavc==-1
                if signal(list+avc)>=0 && xavc==-1
                    xavc=list+avc;
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
                xavc=length(signal);
            end
            %on sauvegarde les intervales dans interv.
            interv(1,1)=xarr;
            interv(1,2)=xavc;
            
        end
    else
        %On fait de meme ici pour chaque sommet de la liste. Et pour chaque
        %sommet, on verifie s'il est negatif ou positif.
        for j=1:length(list)
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;
            %Si le point est positif on parcour de chaque cote du sommet
            %jusqu'a passer en-dessous de la barre des zeros. Sinon on fait 
            %la meme chose mais en passant au-dessus de la barre des zeros.
            if(signal(list(j))>0)
                while (list(j)-arr)>0 && (xarr==-1)
                    if signal(list(j)-arr)<=0 && xarr==-1
                        xarr=list(j)-arr;
                    end
                    arr=arr+1;
                end
                
                while(list(j)+avc)<=length(signal) && xavc==-1
                    if signal(list(j)+avc)<=0 && xavc==-1
                        xavc=list(j)+avc;
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
                %proche de la fin et lors du parcours du signal on depasse
                %pas les zeros, on met le dernier point du signal comme
                %etant le point de fin de l'interval
                if xavc<=0
                    xavc=length(signal);
                end
                %on sauvegarde les intervales dans interv.
                interv(j,1)=xarr;
                interv(j,2)=xavc;
                
            else
                while (list(j)-arr)>0 && (xarr==-1)
                    if signal(list(j)-arr)>=0 && xarr==-1
                        xarr=list(j)-arr;
                    end
                   
                    arr=arr+1;
                end 
                
                while (list(j)+avc)<=length(signal) && xavc==-1
                    if signal(list(j)+avc)>=0 && xavc==-1
                        xavc=list(j)+avc;
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
                %proche de la fin et lors du parcours du signal on depasse
                %pas les zeros, on met le dernier point du signal comme
                %etant le point de fin de l'interval
                if xavc<=0
                    xavc=length(signal);
                end
                
                %on sauvegarde les intervales dans interv.
                interv(j,1)=xarr;
                interv(j,2)=xavc;
                
            end
        end
    end
end