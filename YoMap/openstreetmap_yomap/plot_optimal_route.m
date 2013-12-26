function [] = plot_optimal_route(ax, route, points, parsed_osm)
%
% usage
%   PLOT_ROUTE(ax, route, parsed_osm)
%
% input
%   ax = axes object handle.
%   route = matrix of nodes traversed along route, as returned by the
%           route_planner function.
%   parsed_osm = parsed OpenStreetMap XML data, as returned by the
%                parse_openstreetmap function.
%
%   See also ROUTE_PLANNER, PARSE_OPENSTREETMAP.
%
% File:         plot_route.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.04.24
% Language:     MATLAB R2012a
% Purpose:      plot (over map) the route found by route planner
% Copyright:    Ioannis Filippidis, 2012-

% empty path ?
if isempty(route)
    warning('path is empty. This means that the planner found no path.')
    return
end

% nodexy = parsed_osm.node.xy;
% start_xy = nodexy(:, route(1, 1) );
% path_xy = nodexy(:, route);
% path_end = nodexy(:, route(1, end) );
% 
% held = takehold(ax);
% 
% plotmd(ax, start_xy, 'Color', 'm', 'Marker', 'o', 'MarkerSize', 15)
% plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
% plotmd(ax, path_end, 'Color', 'c', 'Marker', 's', 'MarkerSize', 15)

end_point = points(:, 1);
start_point = points(:,end);
%inverse ploting, starrts from end point
start_xy = route(:, 1); %real end point
path_xy = route(:,:);
path_end = route(:,end);%real start point

if size(route,2) >= 2

    held = takehold(ax);

    if end_point == start_xy
        if start_point == path_end
            plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5) 
            plotmd(ax, start_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            plotmd(ax, end_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
        else
            plot(ax, [points(1,1) route(1,1)], [points(2,1) route(2,1)], 'b', 'LineWidth', 5);
            plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
            plotmd(ax, end_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
            plotmd(ax, start_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            plotmd(ax, path_end, 'Color', 'r', 'Marker', 'o', 'MarkerSize', 15)
        end
    else if start_point == path_end
            plot(ax, [points(1,v) route(1,end)], [points(2,end) route(2,end)], 'b', 'LineWidth', 5);
            plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5) 
            plotmd(ax, start_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            plotmd(ax, end_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
            plotmd(ax, start_xy, 'Color', 'g', 'Marker', 'o', 'MarkerSize', 15)
        else
            plot(ax, [points(1,1) route(1,1)], [points(2,1) route(2,1)], 'b', 'LineWidth', 5);
            plot(ax, [points(1,end) route(1,end)], [points(2,end) route(2,end)], 'b', 'LineWidth', 5);
            plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
            plotmd(ax, start_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
            plotmd(ax, end_point, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
            plotmd(ax, start_xy, 'Color', 'g', 'Marker', 'o', 'MarkerSize', 15)
            plotmd(ax, path_end, 'Color', 'r', 'Marker', 'o', 'MarkerSize', 15)

        end   
    end
% plotmd(ax, start_xy, 'Color', 'r', 'Marker', 'o', 'MarkerSize', 15)
% plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
% plotmd(ax, path_end, 'Color', 'g', 'Marker', 'o', 'MarkerSize', 15)


givehold(ax, held)

end
