%% Importer les données; chaque colonne correspond à un déplacement rectiligne
d  = csvread('TS_DR_Verif_codeMatLab.csv');

nc = size(d,2)
nl = size(d,1)
%% Initialiser les variables
k = 1;
couleur = 1;
cmpt = [];
seuil = -2.5;
c = zeros(1, 10);
interval = zeros(2, 2);
numInt = 1;

c(1) = 1;
interval(numInt, 1) = 1;
%% Déterminer les intervalles de cycles de propulsion
ch = 'NomPousse;MzMax;MzMin;TempsCycle;TempsPoussee;SurfaceSousCycle;Moyenne;Medianne;IQR;EcartType\n';
for i= 1:nc
    y = d(:,i);
    k = 2;
    couleur = 1;
    while k <= nl
        while k <= nl  && y(k) > seuil% lire toutes les valeurs inférieures jusqu'a la première valeures supérieure
                 c(k) = couleur;
                  k = k + 1;
        end
        if k <= nl  && y(k) <= seuil
                 couleur =  mod(couleur + 63, 397);% Changer la couleur
                 aux = k;

                 while aux >=1 &&  0.1 >= y(aux)% Rebrousser chemin jusqu'a trouver le début du cycle de propulsion
                     c(aux) = couleur;
                     aux = aux - 1;
                 end
                 interval(numInt, 1) = (aux == 0)*1 + (~(aux == 0))*aux ;
               
                 if (numInt - 1) > 0
                      interval((numInt - 1), 2) = aux - 1; 
                 end
                 numInt = numInt + 1;
                    
                 %---- Lire toutes les valeurs supérieures en donnant la
                 %couleur
                 while k <= nl && y(k) <= seuil
                         c(k) = couleur;
                          k = k + 1;               
                 end

                 %Lire toutes les valeurs inférieures en donnant la même
                 %couleur
                 while k <= nl && y(k) > seuil 
                     c(k) = couleur;
                      k = k + 1;
                 end
                 k = k - 1;

        end
          
          k = k + 1;
    end
     %interval
     if numInt > 1
         interval((numInt - 1), 2) = nl;
     end
    
%% Calcul des propriétés pour chaque cycle
    
   n = size(interval,1);

  aSousTraire = 0;
   for cmpteur = 1:n
       plot(y(interval(cmpteur,1):interval(cmpteur,2)));
%        system('pause')
       if  abs(interval(cmpteur,2) - interval(cmpteur,1)) <= 20
           aSousTraire = aSousTraire + 1;
           continue
       end
       id = interval(cmpteur,1) + 20;
        while (y(id) <= -0.5)*1 + (~(y(id) <= -0.5))*0
            id = id + 1;
        end

        tPousse = ( id - interval(cmpteur,1) + 1) * 0.001;
        tCycle = ( interval(cmpteur,2) - interval(cmpteur,1) + 1) * 0.001;
        mMz = max(y(interval(cmpteur,1):interval(cmpteur,2)));
        minMz = min(y(interval(cmpteur,1):interval(cmpteur,2)));
        s = trapz(y(interval(cmpteur,1):interval(cmpteur,2)));
        mzMoy = mean(y(interval(cmpteur,1):interval(cmpteur,2)));
        mzMed = median(y(interval(cmpteur,1):interval(cmpteur,2))) ;
        ts = timeseries(y(interval(cmpteur,1):interval(cmpteur,2)));
        Irq = iqr(ts);
        sd = std(y(interval(cmpteur,1):interval(cmpteur,2)));
        
        nomPousse = ['P_' num2str(i) '_' num2str(cmpteur - aSousTraire)];
    
        ch = [ch  nomPousse ';' num2str(mMz) ';' num2str(minMz) ';' num2str(tCycle) ';' num2str(tPousse) ';' num2str(s) ';' num2str(mzMoy) ';' num2str(mzMed) ';' num2str(Irq) ';' num2str(sd) '\n'];
   end
   
%Y(i, :) = y;
%C(i, :) = c;

clearvars c interval; 
k = 1;
interval = zeros(2, 2);
couleur = 1;
c = zeros(1, 10);
numInt = 1;

cmpt = [cmpt '.']

end

%% Classification des poussées à partir de leurs propriétés
system('"C:\Program Files\R\R-3.1.2\bin\i386\R" -q --vanilla < kmoyen.R')
 
%% 

fid = fopen('fichierPropriete.txt','a+');
fprintf(fid, ch);
fclose(fid);



