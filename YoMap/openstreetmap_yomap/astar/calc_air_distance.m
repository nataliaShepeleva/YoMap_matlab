function [ distance ] = calc_air_distance( x1,y1,x2,y2 )
%CALCAIRDISTANCE Summary of this function goes here
%   Detailed explanation goes here
    %Haversine formula
    %http://en.wikipedia.org/wiki/Haversine_formula
    %http://andrew.hedges.name/experiments/haversine/
%   Convert degree to radians
x1_rad = degtorad(x1);
y1_rad = degtorad(y1);
x2_rad = degtorad(x2);
y2_rad = degtorad(y2);

u = sin((x2_rad - x1_rad)./2.0);
v = sin((y2_rad - y1_rad)./2.0);

distance = 2.0 .* 6372.8 .* asin(sqrt(u.*u + cos(x1_rad).*cos(x2_rad).*v.*v));
end