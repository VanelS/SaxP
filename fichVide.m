function [] = fichVide(chemin, nomFichs)
    
    rep = fullfile(chemin,nomFichs);

    list = dir(rep);
    cpt=0;

    disp(['suppression des fichiers vides à l''emplacement : ' nomFichs]);
    for n = 3:numel(list)
        fid = fopen([rep '\' list(n).name],'r');
        while ~feof(fid)
            ligne = fgetl(fid);
            cpt= cpt+1;
            if cpt==10
                break
            end
        end
        if cpt<10
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