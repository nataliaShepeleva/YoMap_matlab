%% name file
openstreetmap_filename = 'data/LeCreusotWaysFF.osm'; %'osm file with data';
parsed_osm_filename = 'data/LeCreusotWaysFF.mat'; %'osm file with data';
map_img_filename = 'data/map20000.png'; % image file saved from online, if available

%any points
xA =4.4076 ; yA =46.7844 ; xB = 4.4378; yB =46.8097 ;
points = [xB xA; yB yA]

%% convert XML -> MATLAB struct 
%read and save to parsed_osm_filename
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename,parsed_osm_filename,2);

%% plot
%global figure
fig = figure;
ax = axes();


%% plot road layer
prepareMap(ax,parsed_osm.bounds);
show_map(ax, parsed_osm.bounds, map_img_filename)
plot_way(ax, parsed_osm)
%plot_way(ax, parsed_osm,map_img_filename)

[x,y] = ginput(2);


%% plot routelayer
route = findShortestWayByPosition(parsed_osm,x(1),y(1),x(2),y(2),1);
plot_optimal_route(ax, route, points, parsed_osm);

