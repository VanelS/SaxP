function [ val ] = valeurAttribut( attribut, ligne )
%prend en paramètre le numéro d'un attribut et une ligne du fichier
%Détermine la valeur de l'attribut dans la ligne.
%Les attributs sont comptés à partir de 1
% ligne
indice = determinePosition(attribut, ligne);
val = calculNbre(indice(1),indice(2),indice(3),ligne);

end

