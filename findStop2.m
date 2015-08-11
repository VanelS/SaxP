function[fin]=findStop2(cycles,time,signal,rotation)
   
    pos =position(rotation(length(rotation),2),time,cycles(length(cycles),2));
    i=position(pos,signal,max(signal(pos:length(signal))));
    
    arr=1;
    fin=-1;
    
    while fin==-1
        if signal(i-arr)<=0
            fin=i-arr;
        end
        arr=arr+1;
    end

end