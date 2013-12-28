function show_Map_Result(ax,map, road, way, category, route, points, parsed_osm, parsed_poi, map_img_filename)
cla reset;
global h;
h = ax;
flag = 0;
prepareMap(ax, parsed_osm.bounds);

if map == 1
   if flag == 1 
       hold(h, 'on');
   end
    prepareMap(h, parsed_osm.bounds);
    show_map(h, parsed_osm.bounds, map_img_filename);
    flag = 1;
end

if road == 1
   if flag == 1
       hold(h, 'on');
   end
   prepareMap(h, parsed_osm.bounds);
   plot_way(h, parsed_osm, map_img_filename);
   flag = 1;
end

if way == 1
    if route ~= 0
        if flag == 1
            hold(h, 'on');
        end
        prepareMap(h, parsed_osm.bounds);
        plot_optimal_route(h, route, points, parsed_osm);
        flag = 1;
    end
end

color = [0.3 0.8 1; 
         0 0.5 1;
         0.1 0.2 0.8;
         0.1 0.1 0.3;
         0.4 1 0.8;
         0 0.9 0.8;
         0 0.3 0.3;
         0 0.2 0.1;
         0.4 0.8 0;
         0.2 0.3 0;
         1 1 0;
         0.9 0.7 0.1;
         0.5 0.3 0.1;
         0.4 0.2 0.1;
         0.2 0.1 0;
         0.9 0.7 0.5;
         0.1 0.3 0.3;
         0.3 0 0;
         1 0 0.3;
         0.6 0 0.6;
         0.4 0 0.3;
         0.2 0.1 0.3;
         0.7 0.5 1;
         0.9 0.4 1;
         0.2 0.2 0.2;
         0.8 0.7 0.7];
if category == 1
    if flag == 1
        hold(h, 'on');
    end
    prepareMap(h, parsed_osm.bounds);
    for i = 1:1:26
        poi = get_names_poi_by_category_id(parsed_poi,i);
        n = size(poi);
        for j = 1:1:n
            result = get_poi_by_id_from_category_id(parsed_poi,i, j);
            x = result.xy(1);
            y = result.xy(2);
            hold(h, 'on');
            plot(h, x,y, 'p','MarkerEdgeColor','b','MarkerFaceColor',color(i,:), 'MarkerSize',12);
        end
    end
    flag = 1;
%     hit_tester()
end
end
% for any case if we need to know which mouse button ispressed

% function hit_tester(varargin)
% global h;
% % Sample code for detecting which mouse button was pressed in a figure.
% if nargin == 0
%    % fig = figure;
%     set(h, 'buttondownfcn', 'hit_tester(get(gcf, ''selectiontype''))');
% else
%     if nargin == 1
%         button = varargin(1);
%         disp(button);
%         end
% end
% end

                