function [] = decoupeCycle(cycles,rot, chemin, fichier, indTemps,time)
    %decoupeCycle est une fonction, comme son nom l'indique, une fonction
    %qui permet de decouper les cycles propulsion et les inserer dans different
    %fichier. En effet, il va lire le fichier passer en parametre et pour
    %chacun des cycles contenu dans la variable cycles nous creons un
    %fichier qui lui correspondant. Si la valeur x lu dans le fichier est
    %egale au debut d'un cycle de rotation, alors nous changeons de numero
    %de deplacement rectiligne.
    
    %ouverture du ficher de donnée
    donnee = fopen([chemin '\' fichier],'r');
    
    if donnee == -1
        error(['impossible douvrir le fichier ' fichier]);
    else
        %nous gardons dans une variable l'en-tete du fichier qui va nous
        %permettre de l'inserer au debut de chaque fichier de cycle
        ligneEntete = fgetl(donnee);
        if ligneEntete == -1
            error('Fichier vide');
        end
        i = 1;
        j = 1;
        ind = 1;
        condition=1;
        %nous definissons le dossier dans lequel va contenir tous les
        %fichiers créer par cette fonction
        aux = [chemin '\' fichier 'decoupe' ];

        if ~exist(aux,'dir')
        	mkdir(aux);
        else
            error(['Le dossier ' aux ' existe déjà']);   
        end
        %ici, on definit le titre du fichier
        NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
        
        %creation du premier fichier de cycle et on lui insert l'entete
        %definie precedemment
        fidR = fopen([aux '\' NFR], 'w');
        fprintf(fidR, [ligneEntete '\n']);
        
        %lecture ligne par ligne du fichier, on garde en memoire la valeur
        %x a laquelle on est pour pouvoir l'inserer dans le bon fichier et
        %bon cycle
        while ~feof(donnee)
            l = fgetl(donnee);
            x = valeurAttribut(indTemps,l);
            %ici, on selection que les x en-dehors de la zone de rotation
            if j<=length(rot) && (x<=time(rot(j,1)) ||  x>=time(rot(j,2)))
                %si x appartient au cycle courant on l'insert de les donnees
                %complete contenue dans l dans le fichier courant
                if i <= length(cycles) && x>=cycles(i,1) && x <= cycles(i,2)
                    fprintf(fidR,[l '\n']);
                end

                %si x correspond au temps du debut de cycle de rotation alors
                %on change de fichier et on change le numero de deplacement
                %rectiligne et on reinitialise l'indice de cycle pour les
                %fichier et on incremente le i pour passer au cycle suivant
                %dans la variable cycles
                if j<=length(rot) && x== time(rot(j,1)) && condition==1
                    fclose(fidR);
                    ind = 1;
                    i=i+1;
                    j=j+1;
                    NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
                    fidR = fopen([aux '\' NFR], 'w');
                    fprintf(fidR, [ligneEntete '\n']);
                    %j'ai choisi d'ajouter une variable condition qui permet de ne 
                    %plus rentrer dans le if actuel et d'avoir j=length(rot) pour pouvoir
                    %rentrer dans le premier if et de continuer l'enregistrement des cycles 
                    %apres le dernier cycle de rotation
                    if j > length(rot)
                        condition=0;
                        j=length(rot);
                    end
                else
                    %sinon, si x appartient au prochain cycle de propulsion, on
                    %change de fichier tous en incrementant l'indice de cycle
                    %pour les fichier et de meme pour i pour passer au cycle
                    %suivant. On lui ajoute l'entete et la ligne courante lu
                    if i < length(cycles) && x>=cycles(i+1,1) && x <= cycles(i+1,2)
                        fclose(fidR);
                        i=i+1;
                        ind = ind + 1;
                        NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
                        fidR = fopen([aux '\' NFR], 'w');
                        fprintf(fidR, [ligneEntete '\n']);
                        fprintf(fidR,[l '\n']);
                    end
                end
            end
        end
        %fermeture des fichiers
        fclose(fidR);
        fclose(donnee);        
    end
end