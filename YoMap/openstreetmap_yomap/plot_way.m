function [] = plot_way(ax, parsed_osm, map_img_filename)
%PLOT_WAY   plot parsed OpenStreetMap file
%
% usage
%   PLOT_WAY(ax, parsed_osm)
%
% input
%   ax = axes object handle
%   parsed_osm = parsed OpenStreetMap (.osm) XML file,
%                as returned by function parse_openstreetmap
%   map_img_filename = map image filename to load and plot under the
%                      transportation network
%                    = string (optional)
%
% See also PARSE_OPENSTREETMAP, EXTRACT_CONNECTIVITY.
%
% File:         plot_way.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.06 - 2012.04.17
% Language:     MATLAB R2012a
% Purpose:      plot parsed OpenStreetMap file
% Copyright:    Ioannis Filippidis, 2010-

% ToDo
%   add double way roads

if nargin < 3
    map_img_filename = [];
end

[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

%disp_info(bounds, size(node.id, 2), size(way.id, 2))
show_ways(ax, bounds, node, way, map_img_filename);

function [] = show_ways(hax, bounds, node, way, map_img_filename)

%plot(node.xy(1,:), node.xy(2,:), '.')

for i=1:size(way.id, 2)
    [key, val] = get_way_tags(way.tag{1,i} );
    
       
        flag=0;
    ind=find(ismember(key,{'highway'}));
    if ~isempty(ind)
        if strcmp(val(1,ind), 'primary')
            flag=1;
        elseif strcmp(val(1,ind), 'primary_link')
            flag=1;
        elseif strcmp(val(1,ind), 'secondary')
            flag=1;
        elseif strcmp(val(1,ind), 'secondary_link')
            flag=1;
        elseif strcmp(val(1,ind), 'tertiary')
            flag=1;
        elseif strcmp(val(1,ind), 'tertiary_link')
            flag=1;
        elseif strcmp(val(1,ind), 'residential')
            flag=1;
        elseif strcmp(val(1,ind), 'unclassified')
            flag=1;
        elseif strcmp(val(1,ind), 'footway')
            flag=2;
        elseif strcmp(val(1,ind), 'steps')
            flag=2;
        elseif strcmp(val(1,ind), 'track')
            flag=3;
        elseif strcmp(val(1,ind), 'raceway')
            flag=3;
        elseif strcmp(val(1,ind), 'service')
            flag=3;
        end
    end
    
    
    % plot highway
    way_nd_ids = way.nd{1, i};
    num_nd = size(way_nd_ids, 2);
    nd_coor = zeros(2, num_nd);
    nd_ids = node.id;
    for j=1:num_nd
        cur_nd_id = way_nd_ids(1, j);
        nd_coor(:, j) = node.xy(:, cur_nd_id == nd_ids);
    end
    
    % plot way (highway = red, other = green)
    if flag == 1
        plot(hax, nd_coor(1,:), nd_coor(2,:), 'b-')
    elseif flag == 2
        plot(hax, nd_coor(1,:), nd_coor(2,:), 'g-')
    elseif flag == 3
        plot(hax, nd_coor(1,:), nd_coor(2,:), 'm-')
    else
        plot(hax, nd_coor(1,:), nd_coor(2,:), 'm-')
    end
    %waitforbuttonpress
end

function [] = disp_info(bounds, Nnode, Nway)
disp( ['Bounds: xmin = ' num2str(bounds(1,1)),...
    ', xmax = ', num2str(bounds(1,2)),...
    ', ymin = ', num2str(bounds(2,1)),...
    ', ymax = ', num2str(bounds(2,2)) ] )
disp( ['Number of nodes: ' num2str(Nnode)] )
disp( ['Number of ways: ' num2str(Nway)] )
