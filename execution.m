function [] = execution()
    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s01\e1\e1_Complet\','S01_MTI_e1.txt');
    B=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s01\e1\e1_Complet\2-S01_MTI_e1.txt');
    X2=B.data(:,1);
    Y2=B.data(:,7);
    gyroCycle=gyroCycles(X2,Y2);

    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s01\e1\e1_Complet\','S01_RD_e1.txt');
    A=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s01\e1\e1_Complet\2-S01_RD_e1.txt');
    X=A.data(:,1);
    Y=A.data(:,7);
    resultat=roueCycles(X,filtfilt(ones(60,1),60,-Y(1:length(Y))));
    
    resultat=sortrows(resultat,1);
    gyroCycle=sortrows(gyroCycle,1);    
    gyroCycle=ajustement(Y,gyroCycle);
    res=resultat;
    
    figure
    plot(X,Y)
    hold on
    
    for i=1:length(res)
        plot(X(res(i,1):res(i,2)),Y(res(i,1):res(i,2)),'r')
    end
    for i=1:length(gyroCycle)
        plot(X(gyroCycle(i,1):gyroCycle(i,2)),Y(gyroCycle(i,1):gyroCycle(i,2)),'g')
    end
    hold off
end