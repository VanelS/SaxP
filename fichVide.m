function [] = fichVide(chemin, nomFichs)
    %fichVide permet de supprimer les fichiers vide d'un dossier.
    rep = fullfile(chemin,nomFichs);

    list = dir(rep);
    cpt=0;

    disp(['suppression des fichiers vides à l''emplacement : ' nomFichs]);
    %Pour chaque fichier a partir du troisieme (car les deux premiers sont 
    %. et ..), s'il y a au moins deux ligne on supprime pas sinon oui et on
    %affiche le nom du fichier.  
    for n = 3:numel(list)
        fid = fopen([rep '\' list(n).name],'r');
        while ~feof(fid)
            ligne = fgetl(fid);
            cpt= cpt+1;
            if cpt==2
                break
            end
        end
        if cpt<2
            fclose(fid);
            cpt=0;
            list(n).name
            delete([rep '\' list(n).name]);
        else
            fclose(fid);
            cpt=0;
        end
        
        
    end
end