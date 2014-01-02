function [ distance ] = calc_distance_route( route )
%CALCAIRDISTANCE Summary of this function goes here
%   Detailed explanation goes here
    %Haversine formula
    %http://en.wikipedia.org/wiki/Haversine_formula
    %http://andrew.hedges.name/experiments/haversine/
%   Convert degree to radians
distance = 0.0;

for ii=1:(size(route,2)-1)
   distance = distance + calc_air_distance_byPoint(route(:,ii),route(:,ii+1)); 
end

end