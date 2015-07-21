function [ A B ] = filtre2( X, Y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = size(X,1);
prec = 1;
suiv = 2;
x(1) = X(1);
y(1) = Y(1);

i = 2;
while suiv <= t
    if X(prec) <= X(suiv)
        x(i) = X(suiv);
        y(i) = Y(suiv);
        i = i + 1;
        prec = suiv;
    end
    suiv = suiv + 1;
end

A = x;
B = y;

end

