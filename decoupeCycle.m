function [] = decoupeCycle(cycles,rot, chemin, fichier, indTemps,time)
    donnee = fopen([chemin '\' fichier],'r');
    
    if donnee == -1
        error(['impossible douvrir le fichier ' fichier]);
    else
        ligneEntete = fgetl(donnee);
        if ligneEntete == -1
            error('Fichier vide');
        end
        i = 1;
        j = 1;
        ind = 1;
        aux = [chemin '\' fichier 'decoupe' ];

        if ~exist(aux,'dir')
        	mkdir(aux);
        else
            error(['Le dossier ' aux ' existe d�j�']);   
        end
        NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
        
        fidR = fopen([aux '\' NFR], 'w');
        fprintf(fidR, [ligneEntete '\n']);
            
        while ~feof(donnee)
            l = fgetl(donnee);
            x = valeurAttribut(indTemps,l);
            
            if x>=cycles(i,1) && x <= cycles(i,2)
                fprintf(fidR,[l '\n']);
            end
            if j<=length(rot) && x== time(rot(j,1))
                fclose(fidR);
                ind = 1;
                i=i+1;
                j=j+1;
                NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
                fidR = fopen([aux '\' NFR], 'w');
                fprintf(fidR, [ligneEntete '\n']);
            else
                if i < length(cycles) && x>=cycles(i+1,1) && x <= cycles(i+1,2)
                    fclose(fidR);
                    i=i+1;
                    ind = ind + 1;
                    NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
                    fidR = fopen([aux '\' NFR], 'w');
                    fprintf(fidR, [ligneEntete '\n']);
                end
            end
        end
       
        fclose(fidR);
        fclose(donnee);
        
        
    end
end