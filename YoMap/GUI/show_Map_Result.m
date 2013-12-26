function show_Map_Result(ax,map, road, way, parsed_osm)
global hshowMap;
global bounds;
openstreetmap_filename = 'LeCreusotWaysFF.osm';%'genoa.osm';
map_img_filename = 'map43000.png'; % image file saved from online, if available
cla reset;

flag = 0;
prepareMap(ax, parsed_osm.bounds);
% if map == 2
%     hold(ax, 'on')
%     hshowMap = show_map(ax, parsed_osm.bounds, map_img_filename);
%     hold(ax, 'off')
%     flag = 1;
% end

if map == 1
   if flag == 1 
       hold(ax, 'on');
   end
    prepareMap(ax, parsed_osm.bounds);
    show_map(ax, parsed_osm.bounds, map_img_filename);
    flag = 1;
end

if road == 1
   if flag == 1
       hold(ax, 'on');
   end
   prepareMap(ax, parsed_osm.bounds);
   plot_way(ax, parsed_osm, map_img_filename);
   flag = 1;
end

% 
% if map == 1
%     if road == 1
%         hold(ax, 'on')
%         hshowMap = show_map(ax, parsed_osm.bounds, map_img_filename);
%         prepareMap(ax, parsed_osm.bounds);
%         plot_way(ax, parsed_osm, map_img_filename);
%         hold(ax, 'off')
%     end
%     if road == 0
%         hold(ax, 'on')
%         hshowMap = show_map(ax, parsed_osm.bounds, map_img_filename);
%         hold(ax, 'off')
%     end
% end
% 
% if map == 0
%     if road == 1
%         prepareMap(ax, parsed_osm.bounds);
%         plot_way(ax, parsed_osm, map_img_filename);
%         %set(hshowMap, 'Visible', 'off')
%     end
%     if road == 0
%         set(hshowMap, 'Visible', 'off')        
%     end
% end
% 
% if road == 0
%     if map == 0
%        % set(hshowMap, 'Visible', 'off')        
%     end
% end
% 
% if road == 1
%     if map == 0
%        prepareMap(ax, parsed_osm.bounds);
%        plot_way(ax, parsed_osm, map_img_filename);
%       % set(hshowMap, 'Visible', 'off')  
%     end
%     if map == 1
%         hold(ax, 'on')
%         hshowMap = show_map(ax, parsed_osm.bounds, map_img_filename);
%         prepareMap(ax, parsed_osm.bounds);
%         plot_way(ax, parsed_osm, map_img_filename);
%         hold(ax, 'off')
%     end
% end


    
