function [ val ] = valeurAttribut( attribut, ligne )
%prend en param�tre le num�ro d'un attribut et une ligne du fichier
%D�termine la valeur de l'attribut dans la ligne.
%Les attributs sont compt�s � partir de 1
% ligne
indice = determinePosition(attribut, ligne);
val = calculNbre(indice(1),indice(2),indice(3),ligne);

end

