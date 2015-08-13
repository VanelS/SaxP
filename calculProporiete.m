function [] = calculProporiete(chemin, complet, propulsion)
    rep1 = fullfile(chemin,complet);
    rep2 = fullfile(chemin,propulsion);

    list1 = dir(rep1);
    list2 = dir(rep2);
    if length(list1)==2 || length(list2) == 2
        disp(['Le dossier ' rep1 ' ou ' rep2 ' est vide.']);
    else
        ch = 'NomPousse;MzMax;MzMin;TempsCycle;TempsPoussee;SurfaceSousCycle;Moyenne;Medianne;IQR;EcartType';
        sortie = fopen([rep1 '\' 'Propriete.txt'], 'w');
        fprintf(sortie, [ch '\n']);
        %Pour chaque fichier a partir du troisieme (car les deux premiers sont 
        %. et ..), s'il y a au moins deux ligne on supprime pas sinon oui et on
        %affiche le nom du fichier.  
        for n = 3:numel(list1)
            comp = importdata([rep1 '\' list1(n).name],';');
            prop = importdata([rep2 '\' list2(n).name],';');
            
            NomPousse=list1(n).name(1:9);
            MzMax=max(comp.data(:,7));%cycle complet
            MzMin=min(comp.data(:,7));%cycle complet
            TempsCycle=comp.data(length(comp.data(:,1)),1)-comp.data(1,1);%cycle complet
            tPousse = prop.data(length(prop.data(:,1)),1)-prop.data(1,1);%cycle de propulsion
            SurfaceSousCycle=trapz(prop.data(:,1),prop.data(:,7));%cycle de propulsion
            Moyenne=mean(comp.data(:,7));%cycle complet
            Medianne=median(comp.data(:,7));%cycle complet
            ts=timeseries(comp.data(:,7), comp.data(:,1));%cycle complet
            IQR=iqr(ts);
            EcartType=std(comp.data(:,7));%cycle complet
            
            fprintf(sortie,[NomPousse ';' num2str(MzMax) ';' num2str(MzMin) ';' num2str(TempsCycle) ';' num2str(tPousse) ';' num2str(SurfaceSousCycle) ';' num2str(Moyenne) ';' num2str(Medianne) ';' num2str(IQR) ';' num2str(EcartType) '\n']);
        end 
        fclose(sortie);
    end
end