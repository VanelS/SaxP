function [interv] = intervale(list,signal)
    taille=size(list);
    interv=[];
    if taille(1,1)==1 && taille(1,2)==1 
        if list > 0
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;

            while (list-arr)>0 && (xarr==-1 ||xavc==-1)
                if signal(list-arr)<=0 && xarr==-1
                    xarr=list-arr;
                end
                if signal(list+avc)<=0 && xavc==-1
                    xavc=list+avc;
                end
                avc=avc+1;
                arr=arr+1;
            end
            interv(1,1)=xarr;
            interv(1,2)=xavc;
        else
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;

            while (list-arr)>0 && (xarr==-1 ||xavc==-1)
                if signal(list-arr)>=0 && xarr==-1
                    xarr=list-arr;
                end
                if signal(list+avc)>=0 && xavc==-1
                    xavc=list+avc;
                end
                avc=avc+1;
                arr=arr+1;
            end
            interv(1,1)=xarr;
            interv(1,2)=xavc;
        end
    else
        for j=1:length(list)
            arr=1;
            avc=1;
            xarr=-1;
            xavc=-1;
            if(signal(list(j))>0)
                while (list(j)-arr)>0 && (xarr==-1 ||xavc==-1)
                    if signal(list(j)-arr)<=0 && xarr==-1
                        xarr=list(j)-arr;
                    end
                    if signal(list(j)+avc)<=0 && xavc==-1
                        xavc=list(j)+avc;
                    end
                    avc=avc+1;
                    arr=arr+1;
                end
                interv(j,1)=xarr;
                interv(j,2)=xavc;
            else
                while (list(j)-arr)>0 && (xarr==-1 ||xavc==-1)
                    if signal(list(j)-arr)>=0 && xarr==-1
                        xarr=list(j)-arr;
                    end
                    if signal(list(j)+avc)>=0 && xavc==-1
                        xavc=list(j)+avc;
                    end
                    avc=avc+1;
                    arr=arr+1;
                end
                interv(j,1)=xarr;
                interv(j,2)=xavc;
            end
        end
    end
end