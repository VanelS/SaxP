function [] = execution()
    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s08\e1\e1_Complet\','e1_MTI.txt');
    B=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s08\e1\e1_Complet\2-e1_MTI.txt');
    X2=B.data(:,1);
    Y2=B.data(:,7);
    resultat2=gyroCycles(X2,Y2);

    virg2point('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s08\e1\e1_Complet\','e1_T_RD.txt');
    A=importdata('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\s08\e1\e1_Complet\2-e1_T_RD.txt');
    X=A.data(:,1);
    Y=A.data(:,7);
    resultat=roueCycles(X,-Y);
    
    resultat=sortrows(resultat,1);
    resultat2=sortrows(resultat2,1);    
    resultat2=ajustement(Y,resultat2);

    r=supRot(resultat,resultat2);
    
    figure
    plot(X,Y)
    hold on
    for i=1:length(resultat2)
        plot(X(resultat2(i,1):resultat2(i,2)),Y(resultat2(i,1):resultat2(i,2)),'g')
    end
    for i=1:length(r)
        plot(X(r(i,1):r(i,2)),Y(r(i,1):r(i,2)),'r')
    end
    hold off
end