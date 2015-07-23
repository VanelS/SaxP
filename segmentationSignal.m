function []= segmentationSignal(chemin, RD,RG,gyr, attribut, indTemps ) 
    %cette fonction realise les differentes etape du decoupage des signaux
    %donné en parametre. Dans un premier temps, il converti les virgules
    %des rzels du fichier en un point. Ensuite, nous stockons les données
    %des differents fichier. Puis nous verifions si la representation
    %graphique des donnees du gyroscope possede des sommets positif
    %depassant le seuil de 1. Si c'est le cas nos transformons ces donnees
    %en données negatif. Ensuite nous lissons tous nous signaux. Apres nous
    %indentifions les differents periode de rotation sur le signal du 
    %gyroscope. Sur ces intervalles nous identifions quel signale de la
    %roue gauche ou de la roue droite possede des piques positif. A partir
    %de cela, nous ajustons les differentes periodes rotations sur les deux
    %signaux. Puis nous effectuons une phase d'identification des
    %differents cycles de propulsion de chaque signaux. Enfin nous 
    %decoupons les signaux originaux en different fichier correspondant au
    %differents cycle (de propulsion ou complet)
    
    virg2point ( chemin, RD );
    virg2point ( chemin, RG);
    virg2point ( chemin, gyr);
    
%     tstart = tic;
%     %extraction des données des fichier 
%     [A D]=lectFich(chemin,RD,attribut,indTemps);
%     [C G]=lectFich(chemin,RG,attribut,indTemps);
%     [E F]=lectFich(chemin,gyr,attribut,indTemps);
%     
%     %on supprime les variables C et E car elle contient comme pour A les
%     %temps qui sont identiques pour ces trois variables
%     clearvars C;
%     clearvars E;
%     
%     telapsed = toc(tstart)
    
    tstart = tic;
    
    un=importdata([chemin '\' RD],';');
    deux=importdata([chemin '\' RG],';');
    trois=importdata([chemin '\' gyr],';');
    
    X=un.data(:,indTemps);
    D=un.data(:,attribut);
    G=deux.data(:,attribut);
    F=trois.data(:,attribut);
    
    telapsed = toc(tstart)
    
    if max(F) > 1
        F=-1*F;
    end
    
    i=60;
    
    %on lisse le signale de la roue gauche (G), de la roue droite (D) et du signale
    %du gyroscope(F). Ce dernier à un lissage moins fort car il a moins de
    %parasite par rapport aux autre signaux
    lisseD = filtfilt(ones(i,1),i,D(1:length(A)));
    lisseG = filtfilt(ones(i,1),i,G(1:length(A)));
    lisseF = filtfilt(ones(30,1),30,F(1:length(A)));
    
    %on identifie les periodes de rotations
    gyroCycle=findCycles2(A,lisseF);
    
    %on répercute ces periodes de rotation sur nos signales RD et RG
    maxRD=-100;
    maxRG=-100;
    for i=1:length(gyroCycle)
        maxRD= max(D(gyroCycle(i,1):gyroCycle(i,2)));
        maxRG= max(G(gyroCycle(i,1):gyroCycle(i,2)));
    end
    
    if maxRD > maxRG
        listRotD=ajustement(D,gyroCycle);
        listRotG=ajustement(G,listRotD);
    else
        listRotG=ajustement(G,gyroCycle);
        listRotD=ajustement(D,listRotG);
    end
    
    %affichage
    figure 
    subplot(2,1,1) 
    hold on
    plot(A,D,'r')
    
    for i=1:length(listRotD)
        plot(A(listRotD(i,1):listRotD(i,2)),D(listRotD(i,1):listRotD(i,2)),'g')
    end
    hold off
    
    subplot(2,1,2) 
    hold on
    plot(A,G,'b')
    
    for i=1:length(listRotG)
        plot(A(listRotG(i,1):listRotG(i,2)),G(listRotG(i,1):listRotG(i,2)),'g')
    end
    hold off
    
    %identification des differents cycles de propulsion
    cycleD=CyclePropulsion(A,lisseD,listRotD);
    cycleG=CyclePropulsion(A,lisseG,listRotG);
    
    %decoupedans plusieur fichier des cycles de propulsion et cycles
    %complet 
    decoupeCycle(cycleD, listRotD , chemin, RD, indTemps,A);
    fichVide(chemin, [RD 'decoupe']);
    cycleComplet(cycleD, listRotD , chemin, RD, indTemps,A);
    fichVide(chemin, [RD 'Cycle Complet']);
    
    decoupeCycle(cycleG, listRotG , chemin, RG, indTemps,A);
    fichVide(chemin, [RG 'decoupe']);
    cycleComplet(cycleG, listRotG , chemin, RG, indTemps,A);
    fichVide(chemin, [RG 'Cycle Complet']);
    

end