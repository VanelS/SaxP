function [un deux trois X D G F] =init(chemin, RD, RG, gyr, attribut, indTemps )

    virg2point ( chemin, RD );
    virg2point ( chemin, RG);
    virg2point ( chemin, gyr);

    un=importdata([chemin '\' ['2-' RD]],';');
    deux=importdata([chemin '\' ['2-' RG]],';');
    trois=importdata([chemin '\' ['2-' gyr]],';');
    
    X=un.data(:,indTemps);
    D=un.data(:,attribut);
    G=deux.data(:,attribut);
    F=trois.data(:,attribut);

end