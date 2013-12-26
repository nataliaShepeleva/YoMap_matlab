% example script for using the OpenStreetMap functions
%
% See also PARSE_OPENSTREETMAP, PLOT_WAY, EXTRACT_CONNECTIVITY,
%          GET_UNIQUE_NODE_XY, ROUTE_PLANNER, PLOT_ROUTE, PLOT_NODES.
%
% File:         usage_example.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.25 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      to illustrate usage of the OpenStreetMap functions for MATLAB
% Copyright:    Ioannis Filippidis, 2010-

% download an OpenStreetMap XML Data file (extension .osm) from the
% OpenStreetMap website:
%   http://www.openstreetmap.org/
% after zooming in the area of interest and using the "Export" option to
% save it as an OpenStreetMap XML Data file, selecting this from the
% "Format to Export" options. The OSM XML is specified in:
%   http://wiki.openstreetmap.org/wiki/.osm

%% name file
%openstreetmap_filename = 'map.osm'; %'genoa.osm';
openstreetmap_filename = 'LeCreusotWaysFF.osm'; %'genoa.osm';
%map_img_filename = 'map.png'; % image file saved from online, if available
map_img_filename = 'E:\Developing\Vibot\test\maps\map13000.png'; % image file saved from online, if available


%% convert XML -> MATLAB struct
% convert the OpenStreetMap XML Data file donwloaded as map.osm
% to a MATLAB structure containing part of the information describing the
% transportation network
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename,'',0);

%% find connectivity
%[connectivity_matrix, intersection_node_indices] = extract_connectivity(parsed_osm);
%intersection_nodes = get_unique_node_xy(parsed_osm, intersection_node_indices);

%% plan a route
%{
% try with the assumption of one-way roads (ways in OSM)
start = 1105; % node id
target = 889;
dg = connectivity_matrix; % directed graph
[route, dist] = route_planner(dg, start, target);
%}

% try without the assumption of one-way roads
% start = 1; % node global index
% target = 9;
% dg = or(connectivity_matrix, connectivity_matrix.'); % make symmetric
% [route, dist] = route_planner(dg, start, target);

%% plot
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on')

% plot the network, optionally a raster image can also be provided for the
% map under the vector graphics of the network
plot_way(ax, parsed_osm,map_img_filename)

%route = findShortestWay(parsed_osm,2049450558,2488312271);
%plot_optimal_route(ax, route, parsed_osm);



[x,y] = ginput(2);

route = findShortestWayByPosition(parsed_osm,x(1),y(1),x(2),y(2),1);
plot_optimal_route(ax, route, parsed_osm);
%findShortestWayByPosition(parsed_osm,x,y,x,y);

%iS = find_closest_segment(parsed_osm.node,parsed_osm.segments,x,y);

%closSeg = [parsed_osm.node.xy(1,parsed_osm.segments.start_pos(iS)) parsed_osm.node.xy(1,parsed_osm.segments.end_pos(iS));parsed_osm.node.xy(2,parsed_osm.segments.start_pos(iS)) parsed_osm.node.xy(2,parsed_osm.segments.end_pos(iS))];


%plotmd(ax,closSeg,'Color','r')

hold(ax, 'off')
% fig = figure;
% ax = axes('Parent', fig);
% hold(ax, 'on')
% 
% plot_way(ax, parsed_osm, map_img_filename) % if you also have a raster image
% 
% %plot_route(ax, route, parsed_osm)
% %only_nodes = 1:10:1000; % not all nodes, to reduce graphics memory & clutter
% %plot_nodes(ax, parsed_osm, only_nodes)
% 
% % show intersection nodes (unseful, but may result into a cluttered plot)
% %plot_nodes(ax, parsed_osm, intersection_node_indices)
% 
% hold(ax, 'off')
