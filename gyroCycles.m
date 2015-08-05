function [t] = gyroCycles(X,signal)
    Y=abs(filtfilt(ones(100,1),100,signal(1:length(signal))));
    plot(X,Y)
    Ysort=sort(Y);

    taille=length(Ysort);
    Ysort=Ysort(ceil(taille/2):taille);
    taille=length(Ysort);
    Q1=ceil(taille/4);
    Q3=ceil(3*taille/4);
    if mod(taille,2)==0
        a=taille/2;
        b=(taille/2)+1;
        Q2=(Ysort(a)+Ysort(b))/2;
    else
        Q2=(taille+1)/2;
    end
    res=Ysort(Q3+1:taille);
    s=1;
    t=[];
    while s<=100 && ~isempty(res)
        maxi=max(res);

        pos=position(1,Y,maxi);
        t=[t,pos];
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;

        while (pos-arr)>0 && (pos+avc)<length(X) && (xarr==-1 ||xavc==-1)
            if Y(pos-arr)<=0.001 && xarr==-1
                xarr=pos-arr;
            end
            if Y(pos+avc)<=0.001 && xavc==-1
                xavc=pos+avc;
            end
            avc=avc+1;
            arr=arr+1;
        end

        for i=xarr:xavc

            if ismember(Y(i),res)

                res(position(1,res,Y(i)))=[];
                Y(i)=-1;
            end
        end
        s=s+1;
    end
end
