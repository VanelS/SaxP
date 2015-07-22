function [] = decoupeCycle(cycles,rot, chemin, fichier, indTemps)
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
            error(['Le dossier ' aux ' existe déjà']);   
        end
        NFR=['Cycle-' num2str(j) '-' num2str(ind) '.txt' ];
        
        fidR = fopen([aux '\' NFR], 'w');
        fprintf(fidR, [ligneEntete '\n']);
            
        while ~feof(donnee)
            l = fgetl(donnee);
            x = valeurAttribut(indTemps,l);
            
            if x>=cycles(i,1) && x <= cycles(i,2)
                fprintf(fidR,[l '\n']);
            end
            if j<=length(rot) && x== rot(j,1)
                fclose(fidR);
                ind = 1;
                i=i+1;
                j=j+1;
                NFR=['Cycle-' num2str(j) '-' num2str(ind) '.txt' ];
                fidR = fopen([aux '\' NFR], 'w');
                fprintf(fidR, [ligneEntete '\n']);
            else
                if i < length(cycles) && x>=cycles(i+1,1) && x <= cycles(i+1,2)
                    fclose(fidR);
                    i=i+1;
                    ind = ind + 1;
                    NFR=['Cycle-' num2str(j) '-' num2str(ind) '.txt' ];
                    fidR = fopen([aux '\' NFR], 'w');
                    fprintf(fidR, [ligneEntete '\n']);
                end
            end
        end
       
        fclose(fidR);
        fclose(donnee);
        
        
    end
end