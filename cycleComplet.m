function [] = cycleComplet(cycles,rot, chemin, fichier, indTemps,time,fin)
    %cycleComplet est une fonction qui permet de decouper les cycles
    %complet et les inserer dans different fichier. En effet, il va lire
    %le fichier passer en parametre et pour chacun des cycles contenu dans 
    %la variable cycles nous creons un fichier qui lui correspondant. Un 
    %cycle complet est un cycle qui commence par le meme point de depart 
    %qu'un cycle de propulsion mais qui se fini au début du prochain cycle 
    %de propulsion. Si la valeur x lu dans le fichier est egale au debut 
    %d'un cycle de rotation, alors nous changeons de numero de deplacement 
    %rectiligne.
    
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
        i = 2;
        j = 1;
        ind = 1;
        condition=1;
        %nous definissons le dossier dans lequel va contenir tous les
        %fichiers créer par cette fonction
        aux = [chemin '\' fichier 'Cycle Complet' ];

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
        %cycle de fin zappé si les donnée n'ont pas d'annomalie à la fin du
        %signal

        while ~feof(donnee)
            l = fgetl(donnee);
            x = valeurAttribut(indTemps,l);
            
            %ici, on selection que les x en-dehors de la zone de rotation
            if j<=length(rot) && (x<=time(rot(j,1)) ||  x>=time(rot(j,2)))
                %Un cycle complet est un cycle qui commence par le meme point de depart
                %qu'un cycle de propulsion mais qui se fini au début du prochain cycle  
                %de propulsion. De ce fait, i indique le cycle suivant et je selectionne
                %les x entre le debut du cycle precedent(i-1) et le debut du cycle i
                if i <= length(cycles) && x>=cycles(i-1,1) && x < cycles(i,1)
                    fprintf(fidR,[l '\n']);
                end
                
                %a cause du fait qu'on utilise le cycle suivant pour enregistrer le cycle
                %courant, on oublie de traiter le dernier cycle. Alors, nous reglons ce 
                %probleme par la condition suivante 
                if i==(length(cycles)+1) && x>=cycles(i-1,1) && x <= fin
                    fprintf(fidR,[l '\n']);
                end
                
                %si x correspond au temps du debut de cycle de rotation alors on change de
                %fichier et on change le numero de deplacement rectiligne et on reinitialise
                %l'indice de cycle pour les fichier et on incremente le i pour passer au 
                %cycle suivant dans la variable cycles.
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
                    if i <= length(cycles) && x>=cycles(i,1) && x <= cycles(i,2)
                        fclose(fidR);
                        i=i+1;
                        ind = ind + 1;
                        NFR=['Cycle-' char(64+j) '-' char(64+ind) '.txt' ];
                        fidR = fopen([aux '\' NFR], 'w');
                        fprintf(fidR, [ligneEntete '\n']);
                    end
                end
            end
        end
        fclose(fidR);
        fclose(donnee);
    end
end

