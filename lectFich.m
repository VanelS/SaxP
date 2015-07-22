function [A B] = lectFich(chemin ,fichier1, attribut, indTemps)

    donnee = fopen([chemin '\' fichier1],'r');
    
    %extraction des données
    if donnee == -1
        error(['impossible douvrir le fichier ' fichier1]);
    else
        ligneEntete = fgetl(donnee);
        if ligneEntete == -1
            error('Fichier vide');
        end
        i = 1;
        while ~feof(donnee)
            l = fgetl(donnee);
            
            x(i, 1) = valeurAttribut(indTemps,l);
            y(i, 1) = valeurAttribut(attribut,l);
            i = i + 1;
        end
        [A B] = filtre2(x,y);
    end
    fclose(donnee);
end