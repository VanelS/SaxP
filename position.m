function [i] = position(depart,signal,cible)
        
    for i= depart : length(signal)
        if signal(i) == cible
            break
        end
    end
        

end