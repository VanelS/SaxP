function [interv] = roueCycles(X,signal)
    y=filtfilt(ones(60,1),60,signal(1:length(signal)));
    plot(X,y)
    tab=[X,y];
    Ysort=sortrows(tab,2);
    taille=length(tab(:,2));
    Ysort=Ysort(ceil(taille/2):taille,:);
    taille=length(Ysort(:,2));
    Q3=ceil(taille/4);
    res=Ysort((Q3+1):taille,:); 
    s=1;
    t=[];
    while s<=500 && ~isempty(res)
        
        maxi=max(res(:,2));
        
        pos=position(1,tab(:,2),maxi);
        t=[t,pos];
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;
        [pos,length(res(:,2))]
        
        while (pos-arr)>0 && xarr==-1
            if tab(pos-arr,2)<=0.5 && xarr==-1
                xarr=pos-arr;
            else
                arr=arr+1;
            end
        end
        if(pos-arr)==0
            xarr=1;
        end
        while (pos+avc)<length(X)&& xavc==-1
            if tab(pos+avc,2)<=0.5 && xavc==-1
                xavc=pos+avc;
            else
                avc=avc+1;
            end 
        end
        if(pos+avc)==length(X)
            xavc=length(X);
        end
            
        [xarr,xavc]
        
        for i=xarr:xavc

            if ismember(tab(i,1),res(:,1))

                res(position(1,res(:,1),tab(i,1)),:)=[];
                tab(i,2)=-1;
            end
        end
        s=s+1;
    end
    
    hold on
    plot(tab(:,1),tab(:,2),'g')
    hold off
    interv=intervale(t,signal);
end