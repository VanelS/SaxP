function [lisse] = lissage(i,signal,X)
    lisse=filtfilt(ones(i,1),i,signal(1:length(X)));
end