function [] = virg2point ( chemin, nomFich )
    %cette fonction permet de changer les vigules en points dans le
    %fichier passer en parametre.
    
    if exist([chemin '\' nomFich], 'file') ~= 2
        error(['Le fichier ' nomFich ' est introuvable'] );   
    end
    fid = fopen([chemin '\' nomFich],'r');
    
    ligne= fgetl(fid);
    if ligne == -1
        fclose(fid);
        error('Fichier vide');   
    else
        %on cree un fichier de sortis pour contenir les modification des
        %lignes lu.
        fsortie = fopen([chemin '\' '2-' nomFich],'w');
        fprintf(fsortie,'%s\r\n',ligne);
        %Pour chaque ligne, on la récupere dans la variable 'ligne', en
        %suite on lui applique la fonction strrep qui va identifier et
        %changer les virgules en points. Enfin on l'insert dans le fichier
        %de sortie.
        while ~feof(fid)
            ligne = fgetl(fid);
            ligne = strrep(ligne, ',', '.');
            ligne=strrep(ligne,'	',';');
            fprintf(fsortie,'%s\r\n',ligne);   
        end
        %on ferme tous les fichiers. On supprime le fichier original qui
        %lui a toujours des virgules. Enfin on renomme le fichier de sortie
        %par le noms du fichier d'origine. 
        fclose(fsortie);
        fclose(fid);
%         delete([chemin '\' nomFich]);
%         movefile([chemin '\' '2-' nomFich],[chemin '\' nomFich]);
    end
    
end