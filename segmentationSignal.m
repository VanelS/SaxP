function []= segmentationSignal(chemin, RD,RG,gyr, attribut, indTemps, automatique ) 
    %cette fonction realise les differentes etape du decoupage des signaux
    %donné en parametre. Dans un premier temps, il converti les virgules
    %des reels du fichier en un point. Ensuite, nous stockons les données
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
    
    [roueD roueG gyros X D G F] =init(chemin, RD, RG, gyr, attribut, indTemps);
    
    i=60;
    %on lisse le signale de la roue gauche (G), de la roue droite (D) et du signale
    %du gyroscope(F). Ce dernier à un lissage moins fort car il a moins de
    %parasite par rapport aux autre signaux
    lisseD = lissage(i,D,X);
    lisseG = lissage(i,G,X);
    lisseF = lissage(30,F,X);

    if automatique == 0
        %on identifie les periodes de rotations
        gyroCycle=findCycles3(X,lisseF);
        listRotD=ajustement(D,gyroCycle);
        listRotG=ajustement(G,gyroCycle);

        %identification des differents cycles de propulsion
        cycleD=CyclePropulsion(X,lisseD,listRotD);
        cycleG=CyclePropulsion(X,lisseG,listRotG);
        
        %identification du dernier point du dernier cycle complet
        finD=findStop2(cycleD,X,lisseD,listRotD);
        finG=findStop2(cycleG,X,lisseG,listRotG);  
        
        %depacement rectiligne
        DepRectD=depRect(cycleD(1,1),listRotD);
        DepRectD=[DepRectD;[listRotD(length(listRotD),2)+1 finD-1]]*0.001;
        DepRectG=depRect(cycleG(1,1),listRotG);
        DepRectG=[DepRectG;[listRotG(length(listRotG),2)+1 finG-1]]*0.001;
        
    else
        
        %on identifie les periodes de rotations
        gyroCycle=gyroCycles(X,F);
        gyroCycle=sortrows(gyroCycle,1); 
        listRotD=ajustement(D,gyroCycle);
        listRotG=ajustement(G,gyroCycle);
        
        %identification du dernier point du dernier cycle complet
        finD=roueCycles(X(3*length(X)/4:length(X)),lisseD(3*length(lisseD)/4:length(lisseD)));
        finG=roueCycles(X(3*length(X)/4:length(X)),lisseG(3*length(lisseG)/4:length(lisseG)));
        finD=sortrows(finD,1);
        finG=sortrows(finG,1);
        finD=finD(length(finD),1)+ 3*length(lisseD)/4;
        finG=finG(length(finG),1)+ 3*length(lisseG)/4;
        listRotD=[listRotD;[finD length(D)]];
        listRotG=[listRotG;[finG length(G)]];
                
        %identification des differents cycles de propulsion
        cycleD=roueCycles(X,-lisseD);
        cycleG=roueCycles(X,-lisseG);
        cycleD=sortrows(cycleD,1);
        cycleG=sortrows(cycleG,1);
        cycleD=(supRot(cycleD,listRotD))*0.001;
        cycleG=(supRot(cycleG,listRotG))*0.001;
        
        %depacement rectiligne
        DepRectD=depRect(cycleD(1,1),listRotD)*0.001;
        DepRectG=depRect(cycleG(1,1),listRotG)*0.001;
        
        
    end
    
    %affichage
    subplot(2,1,1) 
    hold on
    title('Roue Droite')
    plot(X,D,'r')
    for i=1:length(listRotD)
        plot(X(listRotD(i,1):listRotD(i,2)),D(listRotD(i,1):listRotD(i,2)),'g')
    end
    hold off
    
    subplot(2,1,2) 
    hold on
    plot(X,D,'r')
    for i=1:length(gyroCycle)
        plot(X(gyroCycle(i,1):gyroCycle(i,2)),D(gyroCycle(i,1):gyroCycle(i,2)),'g')
    end
    hold off
    
    %affichage
    figure 
    subplot(2,1,1) 
    hold on
    title('Roue Gauche')
    plot(X,G(1:length(X)),'r')
    for i=1:length(listRotG)
        plot(X(listRotG(i,1):listRotG(i,2)),G(listRotG(i,1):listRotG(i,2)),'g')
    end
    hold off
    
    subplot(2,1,2) 
    hold on
    plot(X,G(1:length(X)),'r')
    for i=1:length(gyroCycle)
        plot(X(gyroCycle(i,1):gyroCycle(i,2)),G(gyroCycle(i,1):gyroCycle(i,2)),'g')
    end
    hold off
    
    %decoupedans plusieur fichier des cycles de propulsion et cycles
    %complet 
    decoupeCycle(cycleD, listRotD , chemin, RD, indTemps,X,0);
    fichVide(chemin, [RD 'decoupe']);
    cycleComplet(cycleD, listRotD , chemin, RD, indTemps,X,finD);
    fichVide(chemin, [RD 'Cycle Complet']);
    
    decoupeCycle(cycleG, listRotG , chemin, RG, indTemps,X,0);
    fichVide(chemin, [RG 'decoupe']);
    cycleComplet(cycleG, listRotG , chemin, RG, indTemps,X,finG);
    fichVide(chemin, [RG 'Cycle Complet']);
    
    decoupeCycle(DepRectD, listRotD , chemin, RD, indTemps,X,1);
    decoupeCycle(DepRectG, listRotG , chemin, RG, indTemps,X,1);
    
    calculProporiete(chemin, [RD 'Cycle Complet'],[RD 'decoupe']);
    calculProporiete(chemin, [RG 'Cycle Complet'],[RG 'decoupe']);
end

%     tstart = tic;
%     %extraction des données des fichier 
%     [X D]=lectFich(chemin,RD,attribut,indTemps);
%     [C G]=lectFich(chemin,RG,attribut,indTemps);
%     [E F]=lectFich(chemin,gyr,attribut,indTemps);
%     
%     %on supprime les variables C et E car elle contient comme pour A les
%     %temps qui sont identiques pour ces trois variables
%     clearvars C;
%     clearvars E;
%     
%     telapsed = toc(tstart)
%     
%     tstart = tic;