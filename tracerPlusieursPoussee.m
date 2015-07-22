function [ output_args ] = tracerPlusieursPoussee( repertoire, extension, attribut, indTemps )
%Trace plusieurs poussées contenues dans un dossiers

if ~exist(repertoire,'dir')
        error('Le repertoire n existe pas');
end

chemin = fullfile(repertoire,extension);

list = dir(chemin);

for n = 1:numel(list)
    tracerUnePousse(fullfile(repertoire,list(n).name),attribut,indTemps)
end


end

