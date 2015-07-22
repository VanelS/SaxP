function [bool] = egaleEspace(a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

bool = ~(a=='0'|a=='1'|a=='2'|a=='3'|a=='4'|a=='5'|a=='6'|a=='7'|a=='8'|a=='9'|a==','|a=='.' |a=='-');
end

