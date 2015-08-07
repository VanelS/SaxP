function [i] = position(depart,signal,cible)
    %cette fonction permet de recuperer la position d'une valeur sur un 
    %signal. Elle prend en parametre la position de depart, le signal et la 
    %valeur a identifier sur le signal. On renvoie la premier position de
    %la valeur du signal rechercher.
    
    for i= depart : length(signal)
        if signal(i) == cible
            break
        end
    end
end