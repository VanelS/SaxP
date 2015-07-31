function[fin] = findStop(signal,rotation)
    %Cette fonction permet de definir l'intervale de roue libre pour le
    %dernier cycle, car dans notre algorithme nous caracterisons nos cycles
    %complet comme etant le debut du cycle de propulsion courant jusqu'au
    %debut du cycle de propulsion suivant. Le dernier cycle n'est pris en
    %compte par cette definission.
    arr=1;
    fin=-1;

    %A partir de la fin du dernier cycle jusqu'a la fin du signal, en
    %essaye de trouver le pic accendant de freinage.
    for i=rotation(length(rotation),2):length(signal)-1
        %On caracterise un pic accendant comme etant un point superieur a
        %celui qui le precede et celui qui le suit (.°.).
        if signal(i-1)<signal(i) && signal(i)>signal(i+1) && signal(i)>5
            %A partir du point culminant, on identifie le point de debut
            %du pic.
            while fin==-1
                if signal(i-arr)<=0
                    fin=i-arr;
                end
                arr=arr+1;
            end
            break;
        end
    end
end