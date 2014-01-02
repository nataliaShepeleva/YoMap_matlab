function [ distance ] = calc_air_distance_byPoint( A,B )
%CALCAIRDISTANCE Summary of this function goes here
%   Detailed explanation goes here
    %Haversine formula
    %http://en.wikipedia.org/wiki/Haversine_formula
    %http://andrew.hedges.name/experiments/haversine/
%   Convert degree to radians
distance = calc_air_distance(A(1),A(2),B(1),B(2));
end