function [  ] = tracerUnePousse( nomFich, attribut, indTemps )
%Cette fonction trace une poussee

if exist(nomFich, 'file') ~= 2
    error(['Le fichier ' nomFich ' est introuvable'] );   
end

 fid = fopen(nomFich,'r');
 
  ligneEntete = fgetl(fid);
 if ligneEntete == -1
     error('Fichier vide');
 end
 i = 1;
 l = fgetl(fid);
 x(i, 1) = valeurAttribut(indTemps,l); %-----la fonction ne marche pas pour l'attribut 1
 y(i, 1) = valeurAttribut(attribut,l);
 i = i + 1;

 
  %Parcourir toutes les lignes du fichier et récupérer le dernier temps de
 while ~feof(fid)
      l = fgetl(fid);
       x(i, 1) = valeurAttribut(indTemps,l); %-----la fonction ne marche pas pour l'attribut 1
       y(i, 1) = valeurAttribut(attribut,l);
       i = i + 1;
 end
 [A B] = filtre2(x, y);
fclose(fid);


nbCharNomFich = size(nomFich, 2);
i = nbCharNomFich;
while i >= 1
    if nomFich(i) == '\'
        break;
    end
    i = i - 1;
end

titre = nomFich((i+1):(nbCharNomFich - 4));

 fig=figure
%Créer une nouvelle figure
plot(A,B,'-x');
%Génère un graphe avec x en abscisse et y en ordonnée
axis tight
%Ajuste les axes à la figure
grid on
%Trace une grille
xlabel('temps')
%Titre de l'axes des abscisses
ylabel('Mz')
%Titre de l'axe des ordonnées
title(titre)
%Titre de la figure
%legend('x*x')
%Légende de la figure
%area(A,B) % Trace la surface sous la courbe

saveas(fig,[nomFich '.jpeg'],'jpg');


end

