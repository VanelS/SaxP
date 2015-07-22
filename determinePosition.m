function [ indices] = determinePosition( attribut, ligne )

%prend en paramètre un entier correspondant au numéro d'un attribut
%et une ligne du fichier et retourne pour la valeur de cet attribut dans la
%ligne la position de la première case où commence le nombre, la postion de
%la virgule et la position de la case ou termine le nombre

cmpteurAttribut = 1;
indiceCourant = 2;
taille = size(ligne, 2);
debut = 0;
virgule = 0;
fin = 0;


%Cas ou l'indice de l'attribut est 1
if attribut == 1
        debut = indiceCourant - 1;
        b = 0;
        while indiceCourant <= taille && ~egaleEspace(ligne(indiceCourant))
            if ligne(indiceCourant)==',' || ligne(indiceCourant)=='.'
                virgule = indiceCourant;
                b = 1;
            end
            indiceCourant = indiceCourant + 1;
        end
        fin = indiceCourant - 1;
        if b == 0
            fin = fin + 1;
            virgule = fin;
        end
            
else 
    while indiceCourant <= taille && cmpteurAttribut ~= attribut
            %Recherche de l'attribut dans la ligne
            if egaleEspace(ligne(indiceCourant-1)) && ~egaleEspace(ligne(indiceCourant))
                cmpteurAttribut = cmpteurAttribut + 1;
            end
            indiceCourant = indiceCourant + 1;
    end
    %Traitement de l'attribut

    if attribut == cmpteurAttribut
            debut = indiceCourant - 1;
            while indiceCourant <= taille && ~egaleEspace(ligne(indiceCourant))
                if ligne(indiceCourant)==',' || ligne(indiceCourant)=='.'
                    virgule = indiceCourant;
                end
                indiceCourant = indiceCourant + 1;
            end
                fin = indiceCourant - 1;
     end
    
end
 
indices(1) = debut; 
indices(2) = virgule; 
indices(3)= fin;
end

