function [] = fichVide2(chemin, nomFichs)
    %fichVide permet de supprimer les fichiers considérer comme vide d'un dossier.
    %Dans notre cas, c'est lorsqu'il n'y a que la presence de la ligne
    %d'en-tete.
    rep = fullfile(chemin,nomFichs);

    list = dir(rep);
    

    disp(['suppression des fichiers vides à l''emplacement : ' nomFichs]);
    %Pour chaque fichier a partir du troisieme (car les deux premiers sont 
    %. et ..), si A est de type cell alors on sait que le fichier qu'a 
    %importer A ne comptenait que la ligne d'en-tete. Donc on peut supprimer
    %.ce fichier 
    for n = 3:numel(list)
        A=importdata([rep '\' list(n).name]);
        
        if iscell(A)
            list(n).name
            delete([rep '\' list(n).name]);
        end
    end
end