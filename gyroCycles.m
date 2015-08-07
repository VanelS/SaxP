function [interv] = gyroCycles(X,signal,roue)
    Y=filtfilt(ones(125,1),125,signal(1:length(signal)));
    
    if roue == 0
        plot(X,Y)
        Y=abs(Y);
        Ysort=sort(Y);
        taille=length(Ysort);
        Ysort=Ysort(ceil(taille/2):taille);
        taille=length(Ysort);
        Q3=ceil(3*taille/4);
        res=Ysort(Q3+1:taille); 
    else
        plot(X,Y)
        Ysort=Y;
        Ysort=sort(Ysort);
%         taille=length(Ysort);
%         Ysort=Ysort(ceil(taille/2):taille);
        taille=length(Ysort);
        Q1=ceil(taille/4);
%         if mod(taille,2)==0
%             Q2=taille/2 + 1;
%         else
%             Q2=(taille+1)/2;
%         end
         res=Ysort(Q1+1:taille); 
    end
    
    
    s=1;
    t=[];
    while s<=500 && ~isempty(res)
        length(res)
        maxi=max(res);

        pos=position(1,Y,maxi);
        t=[t,pos];
        arr=1;
        avc=1;
        xarr=-1;
        xavc=-1;

        while (pos-arr)>0 && (pos+avc)<length(X) && (xarr==-1 ||xavc==-1)
            if Y(pos-arr)<=0.01 && xarr==-1
                xarr=pos-arr;
            else
                arr=arr+1;
            end
            if Y(pos+avc)<=0.01 && xavc==-1
                xavc=pos+avc;
            else
                avc=avc+1;
            end
            
            
        end
        [xarr,xavc]
        for i=xarr:xavc

            if ismember(Y(i),res)

                res(position(1,res,Y(i)))=[];
                Y(i)=-1;
            end
        end
        s=s+1;
    end
    
    hold on
    plot(X,Y,'g')
    hold off
    interv=intervale(t,signal);
end