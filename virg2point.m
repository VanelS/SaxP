function [] = virg2point ( chemin, nomFich )
    if exist([chemin '\' nomFich], 'file') ~= 2
        error(['Le fichier ' nomFich ' est introuvable'] );   
    end
    fid = fopen([chemin '\' nomFich],'r');
    
    ligne= fgetl(fid);
    if ligne == -1
        fclose(fid);
        error('Fichier vide');   
    else
        fsortie = fopen([chemin '\' '2-' nomFich],'w');
        fprintf(fsortie,'%s\r\n',ligne);
        
        while ~feof(fid)
            ligne = fgetl(fid);
            ligne = strrep(ligne, ',', '.');
            fprintf(fsortie,'%s\r\n',ligne);   
        end
        fclose(fsortie);
        fclose(fid);
        delete([chemin '\' nomFich]);
        movefile([chemin '\' '2-' nomFich],[chemin '\' nomFich]);
    end
    
end