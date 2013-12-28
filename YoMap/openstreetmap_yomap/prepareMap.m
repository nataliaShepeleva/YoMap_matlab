function [] = prepareMap( ax, bounds )
%PREPAREMAP Summary of this function goes here
%   Detailed explanation goes here
hold(ax, 'on')
    plot(ax, [bounds(1,1), bounds(1,1), bounds(1,2), bounds(1,2), bounds(1,1)],...
         [bounds(2,1), bounds(2,2), bounds(2,2), bounds(2,1), bounds(2,1)],...
         'ro-')

xlabel(ax, 'Longitude (^o)')
ylabel(ax, 'Latitude (^o)')
title(ax, 'OpenStreetMap osm file')

axis(ax, 'image')
axis(ax, [bounds(1, :), bounds(2, :) ] )
lat_lon_proportions(ax)

end

