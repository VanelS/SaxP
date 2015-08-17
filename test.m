function [  ] = test( )
% %Dans une premiere partie, cette fonction ne fais que de tracer une ou plusieurs graphique d'une ou
% %plusieurs fichier.

% nomDossier = 'Resultats';
% nomVolontaire = 'S08';
% nomFich = 'S08_T_RD.csv';%'test.csv';
% chemin = pwd
%      aux = [chemin '\' nomDossier '\' nomVolontaire '\' nomFich];
     %MzMax(fullfile(aux,'P5.txt'))
%      tc = TempsDeCycle(fullfile(aux,'P5.txt'))
%      tp = tempsDePoussee(fullfile(aux,'P5.txt'), -8)
     %s = SurfaceCyclePropulsion(fullfile(aux,'P6.txt'))
     %tracerUnePousse(fullfile(aux,'P1_2.txt'), 8);
     
tracerPlusieursPoussee('C:\Users\jijanera\Downloads\donnee\donneesATraiter_Rachid\donneesATraiter\S01\e1\e1_Complet\S01_RD_e1.txtCycle Complet','*.txt',7,1);
% tracerPlusieursPoussee('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\CyclesDePropulsion\DonneesATraiter\S07_RD_e2H0.csv','*.txt',8,2);
% tracerPlusieursPoussee('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\CyclesDePropulsion\DonneesATraiter\S09_RD_e2_H0.csv','*.txt',8,2);
% tracerPlusieursPoussee('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\CyclesDePropulsion\DonneesATraiter\S09_RG_e2_H0.csv','*.txt',8,2);
% tracerPlusieursPoussee('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\CyclesDePropulsion\DonneesATraiter\S09_RD_e3_H-4.csv','*.txt',8,2);
% tracerPlusieursPoussee('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\CyclesDePropulsion\DonneesATraiter\S09_RG_e3_H-4.csv','*.txt',8,2);

% afficherPousseesCluster('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\Cluster\cluster_1.txt', 8, 2, ';' )
% tracerUnePousse('C:\Users\siyou\Desktop\version_code_sax-p\SAX-P_donnees_23-04-2015\DonneesATraiter\S07_RD_e1H4.csv',7,1);
% tracerUnePousse('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\DonneesATraiter\S09_RG_e1H4.csv',7,1);
% 
% tracerUnePousse('C:\Users\jijanera\Downloads\S07\S07\S07_Complet\S07_MTI.csv',7,1);
% deplacementRectiligne2('C:\Users\siyou\Desktop\version_code_sax-p\SAX-P_donnees_23-04-2015\DonneesATraiter\S07_RG_e2H0.csv',7)
% deplacementRectiligne2( 'C:\Users\siyou\Desktop\version_code_sax-p\SAX-P_donnees_23-04-2015\DonneesATraiter\S10_RD_e2H-4.csv',1, 7, 5,-5 )
% tracerUnePousse('C:\Users\siyou\Desktop\version_code_sax-p\SAX-P_donnees_23-04-2015\DonneesATraiter\S10_RG_e2H-4.csv',7,1);
% 
% tracerUnePousse('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\DonneesATraiter\S10_RD_e2H-4.csv',7,1);
% tracerUnePousse('C:\Users\siyou\Desktop\SAX_etoile_04-03-2015\DonneesATraiter\S09_RG_e3_H-4.csv',7,1);






%      calculDeProprietes(aux, 'fichierDeProprietes.txt', '*.txt')


% distanceEntrePoussees( fullfile(aux,'P1_2.txt'), fullfile(aux,'P3_2.txt'), 8)
%distanceEntreToutesPoussees( 'C:\Users\Vanel\Desktop\codeMatlab_28-07-2014\codeExtraireCyclePropulsion_11-07-2014\Resultats\cyclesDePropulsion', 'fichierDeDistance.txt', '*.txt', 8)

%distanceEntrePousseesCluster('C:\Users\Vanel\Desktop\docBureau\codeMatlab_28-07-2014\codeExtraireCyclePropulsion_11-07-2014\Resultats\cluster_B.txt', 'C:\Users\Vanel\Desktop\docBureau\codeMatlab_28-07-2014\codeExtraireCyclePropulsion_11-07-2014\Resultats\cluster_E.txt', 8)


%supprimerDoublonChaine(' ','bonjour           à             tous')
%coupeChaine('Bonjour à tous', ' ')
%representationSymbolique('clusterN.txt', 'symbole.txt', ' ');

%centrerReduire([1 4; 2 5; 3 6; 4 7])
%centrerReduirePousse('P_S08_T_RD_1_1.txt','scale_',2,8,';');

%centrerReduireTtePousse( 'C:\Users\siyou\Desktop\CodeMemoireMaster\SAX_etoile_09-10-2014\Resultats\S08\S08_T_RD.csv', 'pousseesCentreReduites', '*.txt', 'scale', 2, 8, ';');
%enregClusterDiffFich( 'symbole.txt', 'Cluster_', 'Cluster', ' ');

%Vecteur de propriétés de la roue droite
%M = [6.53 6.47 4.09 1.88 1.09 0.02 -1.31 -2.11;-0.89 -0.73 2.94 4.23 -2.39 2.33 -4.5 -3.98; -0.6 -0.74 0.14 0.15 -0.05 4.15 -0.63 0.46; -0.03 -0.03 -3.15 -2.95 -5.36 1 2.6 1.83; -0.61 -0.64 -3.24 -4.04 -0.49 -1.57 4.74 3.81];
% M=[2.68 2.64 0.8 0.01 -0.39 -0.60 -0.92 -1.73; 4.54 4.28 -5.92 0.74 0.61 0.43 -5.56 -5.21; -1.33 -2.55 0.67 0.87 6.22 6.25 1.83 1.71; -1.80 -1.33 0.99 3.44 -0.64 -0.49 1.33 1.56; -3.65 -3.38 2.30 -2.99 -1.54 -1.36 2.97 3.32];
% M=[2.79 -2.69 -2.4 -0.27 5.23 0.90 0.29 4.34; 
%     1.52 -2.44 -2.27 -0.4 4.23 0.96 0.43 4.25; 
%     12.87 -5.57 -5.45 -0.94 7.58 0.97 0.47 12.87;  
%     2.01 0.53 5.82 0.54 0.26 10.16 10.16 0.32; 
%     1.91 -9.8 -12.93 -9.12 9.35 1.32 0.87 19.52];

% M = [7.87  13.34 -0.86 -5.80 1.71 -20.84 -5.68 0.97 0.47;
%     0.26 0.32 0.54 0.53 2.01 -0.45 5.82 10.16 10.16;
%     2.77 2.15 -0.29 -1.39 1.49 -8.62 -1.35 1.04 0.58;
%     5.19 6.14 -0.59 -3.24 1.61 -14.99 -2.99 0.91 0.35;
%     5.29 4.11 -0.21 -2.63 2.85 -15.81 -2.37 0.90 0.28;
%     9.35 19.52 -9.12 -9.80 1.91 -23.61 -12.93 1.32 0.87]
% distanceEntreVecteurMoyenneDeProp(M)
% calculDeProprietes(aux, 'fichierDeProprietes.txt', '*.txt');

end

