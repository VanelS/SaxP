function [] = execution()
    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s02\e3\e3_Complet\','S02_MTI_e3H4.txt');
    B=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s02\e3\e3_Complet\2-S02_MTI_e3H4.txt');
    X2=B.data(:,1);
    Y2=B.data(:,7);
    resultat2=gyroCycles(X2,Y2);

    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s02\e3\e3_Complet\','S02_RD_e3H4.txt');
    A=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s02\e3\e3_Complet\2-S02_RD_e3H4.txt');
    X=A.data(:,1);
    Y=A.data(:,7);
    resultat=roueCycles(X,-Y);
    
    resultat=sortrows(resultat,1);
    resultat2=sortrows(resultat2,1);    
    resultat2=ajustement(Y,resultat2);
    res=supRot(resultat,resultat2);
    
    figure
    plot(X,Y)
    hold on
    for i=1:length(resultat2)
        plot(X(resultat2(i,1):resultat2(i,2)),Y(resultat2(i,1):resultat2(i,2)),'g')
    end
    for i=1:length(res)
        plot(X(res(i,1):res(i,2)),Y(res(i,1):res(i,2)),'r')
    end
    hold off
end