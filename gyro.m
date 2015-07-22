function[cycle]= gyro()
    donnee=fopen('C:\Users\jijanera\Downloads\S07\S07\S07_Complet\S07_MTI.csv','r');
    if donnee == -1
            error(['impossible douvrir le fichier ' 'E1_MTI.csv']);
    else
        ligneEntete = fgetl(donnee);
        i = 1;
        t=7;
            while ~feof(donnee)
                l = fgetl(donnee);
                x(i, 1)= valeurAttribut(1 ,l);
                y(i, 1)= valeurAttribut(t ,l);
                i = i + 1;
            end
			if max(y) > 1
				F=-1*y;
			end
            [X S] = filtre2(x,y);
            i=30;
            Y = filtfilt(ones(i,1),i,S);
            
            A=0;
            i=2;
            seuil=-1;
            
            %recherche des différents point maximal de chaque cycle de propultion
            while i<=length(Y)-1
                if Y(i) < Y(i-1) && Y(i) < Y(i+1) && Y(i)<seuil

                   A=[A;i];
                   %ici dès que l'on trouve un sommet de cycle, on parcours les
                   %points suivant jusqu'à sortir du cycle pour reprendre la
                   %recherche d'autre cycle
                   while Y(i) < seuil && i<=length(Y)-1
                       i=i+1;
                   end

                end
                i=i+1;
            end
            hold on

            %     plot(X,Y)

            cycle=zeros(length(A)-2,2);
            
            for j=2:length(A)
                arr=1;
                avc=1;
                xarr=-1;
                xavc=-1;

                %recherche du début de cycle 
                while (A(j)-arr)>0 && xarr==-1
                    if (Y(A(j)-arr+1)-Y(A(j)-arr))/(X(A(j)-arr+1)-X(A(j)-arr))>=0 && Y(A(j)-arr)>-1
                        xarr=A(j)-arr;
                    end
                    arr=arr+1;
                end
                %recherche de fin de cycle
                while (A(j)+avc)<length(X) && xavc==-1
                    if (Y(A(j)+avc +1)-Y(A(j)+avc))/(X(A(j)+avc+1)-X(A(j)+avc))<=0 && Y(A(j)+avc)>-1
                        xavc=A(j)+avc;

                    end
                    avc=avc+1;
                end 
                %sauvegarde des points de fin et début de cycle

                cycle(j-1,1)= xarr;
                cycle(j-1,2)= xavc;
            %         scatter(xarr,Y(A(j)-(arr-1)),25,'filled');
            %         scatter(xavc,Y(A(j)+(avc-1)),25,'filled');

            end
    end
    fclose(donnee);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',2,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',3,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',4,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',5,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',6,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',7,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',8,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',9,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',10,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',11,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',12,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',13,1);
% filtreFFT('C:\Users\jijanera\Downloads\donneesATraiter_Rachid\donneesATraiter\S03\E1\E1_Complet','E1_MTI.csv',14,1);

end