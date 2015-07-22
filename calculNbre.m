function [ nbreReel ] = calculNbre( posDebut, posVirgule, posFin, T )
%Prend en paramètre un tableau de chiffres et retourne le nombre réelle
%correspondant

% %Partie entière
% i = posDebut;
% nbre = 0;
% 
% while i < posVirgule
%     nbre = nbre + 10^(posVirgule - i - 1) * str2double(T(i));
%     i = i + 1;
% end
% 
% %Partie décimale
% i = posVirgule + 1;
% while i <= posFin
%     nbre = nbre + 10^(posVirgule - i) * str2double(T(i));
%     i = i + 1;
% end
% 
% if posDebut-1 > 0 && T(posDebut-1)=='-'
%     nbre = nbre * -1;
% end
% %format long
n = '';

if T(posDebut) == ' '
     n = T((posDebut+1):(posVirgule - 1));
else
     n = T((posDebut):(posVirgule - 1));
end


n = [n '.' T((posVirgule+1):posFin)];

nbreReel = str2double(n);%nbre;