function [parsed_osm] = parse_osm_modified(osm_xml)
%PARSE_OSM  Creates new structure from loaded OSM XML structure.
%   parsed_osm = PARSE_OSM(osm_xml) takes as input a MATLAB structure
%   osm_xml containing the XML data loaded from an OpenStreetMap file using
%   function load_osm_xml, and returns another MATLAB structure containing
%   a subset of these data parsed appropriately for further usage by other
%   functions.
%
% See also PARSE_OPENSTREETMAP, LOAD_OSM_XML.
%
% File:         parse_osm.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      parse loaded OpenStreetMap xml structure
% Copyright:    Ioannis Filippidis, 2010-

% memo about osm contents
%   data primitives
%       1) nodes
%           id (unique between nodes)
%           lat \in [-90, 90] (latitude)
%           lon \in [-180, 180] (longitude)
%           ele (elevation  = altitude - optional)
%           tags
%       2) ways    (& closed ways = areas)
%           id
%           nodes (node ids)
%           tags
%       3) relations
%           members
%           tags (k=v)
%           Attributes

parsed_osm.bounds = parse_bounds(osm_xml.bounds);
parsed_osm.node = parse_node(osm_xml.node);
[parsed_osm.node,parsed_osm.way] = parse_way(osm_xml.way,parsed_osm.node);
%parsed_osm.way = parse_way(osm_xml.way);
%parsed_osm.relation = parse_relation(osm.relation);

[parsed_osm.node,parsed_osm.segments] = parse_segments(parsed_osm.node,parsed_osm.way);

parsed_osm.Attributes = osm_xml.Attributes;

function [parsed_bounds] = parse_bounds(bounds)
bounds = bounds.Attributes;

ymax = str2double(bounds.maxlat);
xmax = str2double(bounds.maxlon);
ymin = str2double(bounds.minlat);
xmin = str2double(bounds.minlon);

parsed_bounds = [xmin, xmax; ymin, ymax];

function [parsed_node] = parse_node(node)
Nnodes = size(node,2);

id = zeros(1, Nnodes);
xy = zeros(2, Nnodes);
ways = cell(1, Nnodes);
outgoing_segments=cell(1, Nnodes);

for i=1:Nnodes
    id(1,i) = str2double(node{i}.Attributes.id);
    xy(:,i) = [str2double(node{i}.Attributes.lon);...
               str2double(node{i}.Attributes.lat)];
end
parsed_node.id = id;
parsed_node.xy = xy;
parsed_node.ways = ways;
parsed_node.outgoing_segments = outgoing_segments;

function [parsed_nodes,parsed_way] = parse_way(way,parsed_nodes)
Nways = size(way,2);

id = zeros(1, Nways);
nd = cell(1, Nways);
tag = cell(1, Nways);
for i=1:Nways
    waytemp = way{i};
    
    id(1,i) = str2double(waytemp.Attributes.id);
    
    Nnd = size(waytemp.nd, 2);
    ndtemp = zeros(1, Nnd);
    for j=1:Nnd
        nd_id = str2double(waytemp.nd{j}.Attributes.ref);
        ndtemp(1, j) = nd_id;
        node_place_idx = find(parsed_nodes.id==nd_id,1);
        
        temp_nodes = parsed_nodes.ways{node_place_idx};
        temp_nodes(1,size(temp_nodes,2)+1)= id(1,i);
        parsed_nodes.ways{node_place_idx} = temp_nodes;
        
    end
    nd{1, i} = ndtemp;
    
    % way with or without tag(s) ?
    if isfield(waytemp, 'tag')
        tag{1, i} = waytemp.tag;
    else
        tag{1, i} = []; % no tags for this way
    end
    
%     Ntag = size(waytemp.tag,2);
%     for k=1:Ntag
%         if(strcmp(waytemp.tag{k}.Attributes.k,'name'))
%             tag{1,i} = gr2gren(waytemp.tag{k}.Attributes.v);
%         end
%     end
end
parsed_way.id = id;
parsed_way.nd = nd;
parsed_way.tag = tag;



function [parsed_nodes,parsed_segments] = parse_segments(parsed_nodes,parsed_ways)

Nways = size(parsed_ways.id,2);
Nsegments=1;
for i=1:Nways
    [key, val] = get_way_tags(parsed_ways.tag{1,i});
    
    % way = highway or amenity ?
    flag = 0;
    
    if ~isempty(ismember(key,{'highway'}))
        flag = 1;
    elseif ~isempty(ismember(key,{'building'}))
        flag = 2;
    end
    
    if flag==1
        %Determine the type of road we have
        type_road=0;
        ind=find(ismember(key,{'highway'}));
        if strcmp(val(1,ind), 'primary')
            type_road=1;
        elseif strcmp(val(1,ind), 'primary_link')
            type_road=2;
        elseif strcmp(val(1,ind), 'secondary')
            type_road=3;
        elseif strcmp(val(1,ind), 'secondary_link')
            type_road=4;
        elseif strcmp(val(1,ind), 'tertiary')
            type_road=5;
        elseif strcmp(val(1,ind), 'tertiary_link')
            type_road=6;
        elseif strcmp(val(1,ind), 'residential')
            type_road=7;
        elseif strcmp(val(1,ind), 'unclassified')
            type_road=8;
        elseif strcmp(val(1,ind), 'footway')
            type_road=9;
        elseif strcmp(val(1,ind), 'steps')
            type_road=10;
        elseif strcmp(val(1,ind), 'track')
            type_road=11;
        elseif strcmp(val(1,ind), 'raceway')
            type_road=12;
        elseif strcmp(val(1,ind), 'service')
            type_road=13;       
        end
        
        %public or private
        type_access=0;        
        ind=find(ismember(key,{'access'}));
        if ~isempty(ind)
            if strcmp(val(1,ind), 'privat')
                type_access=1;
            elseif strcmp(val(1,ind), 'truck')
                type_access=2;   
            end
        end
        
        %oneway
        segment_mode=2;
        ind=find(ismember(key,{'oneway'}));

        if ~isempty(ind)
            if strcmp(val(1,ind), 'yes')
                %i
                segment_mode=0;
            elseif strcmp(val(1,ind), 'no')
                segment_mode=2;
            elseif strcmp(val(1,ind), '-1')
                segment_mode=1;
            end
        end
        
        %junction
        ind=find(ismember(key,{'junction'}));
        if ~isempty(ind)
            if strcmp(val(1,ind), 'roundabout')
                segment_mode=0;
            end   
        end
        
       
        Nnd = size(parsed_ways.nd{1,i},2);
        %-1 because we are linking pre_last will be with last
        for j=1:Nnd-1
            if segment_mode==0
                %one way street
                way_id(1,Nsegments) = parsed_ways.id(i);
                A(1,Nsegments) = parsed_ways.nd{1,i}(j);
                B(1,Nsegments) = parsed_ways.nd{1,i}(j+1);
                A_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j));
                B_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j+1));
                d(1,Nsegments) = calc_air_distance(parsed_nodes.xy(1,A_pos(1,Nsegments)),parsed_nodes.xy(2,A_pos(1,Nsegments)),parsed_nodes.xy(1,B_pos(1,Nsegments)),parsed_nodes.xy(2,B_pos(1,Nsegments)));
                road_type(1,Nsegments) = type_road;
                access_type(1,Nsegments) = type_access;
                %add index of segment to outgoing indexlist of node
                temp_seg = parsed_nodes.outgoing_segments{A_pos(1,Nsegments)};
                temp_seg(1,size(temp_seg,2)+1)= Nsegments;
                parsed_nodes.outgoing_segments{A_pos(1,Nsegments)} = temp_seg;
                
                Nsegments=Nsegments+1;
            elseif segment_mode==1
                %opposite one way
                way_id(1,Nsegments) = parsed_ways.id(i);
                B(1,Nsegments) = parsed_ways.nd{1,i}(j);
                A(1,Nsegments) = parsed_ways.nd{1,i}(j+1);
                B_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j));
                A_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j+1));
                d(1,Nsegments) = calc_air_distance(parsed_nodes.xy(1,A_pos(1,Nsegments)),parsed_nodes.xy(2,A_pos(1,Nsegments)),parsed_nodes.xy(1,B_pos(1,Nsegments)),parsed_nodes.xy(2,B_pos(1,Nsegments)));
                road_type(1,Nsegments) = type_road;
                access_type(1,Nsegments) = type_access;
                
                %add index of segment to outgoing indexlist of node
                temp_seg = parsed_nodes.outgoing_segments{A_pos(1,Nsegments)};
                temp_seg(1,size(temp_seg,2)+1)= Nsegments;
                parsed_nodes.outgoing_segments{A_pos(1,Nsegments)} = temp_seg;
                
                Nsegments=Nsegments+1;  
            elseif segment_mode==2
                %two way
                way_id(1,Nsegments) = parsed_ways.id(i);
                A(1,Nsegments) = parsed_ways.nd{1,i}(j);
                B(1,Nsegments) = parsed_ways.nd{1,i}(j+1);
                A_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j));
                B_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j+1));
                d(1,Nsegments) = calc_air_distance(parsed_nodes.xy(1,A_pos(1,Nsegments)),parsed_nodes.xy(2,A_pos(1,Nsegments)),parsed_nodes.xy(1,B_pos(1,Nsegments)),parsed_nodes.xy(2,B_pos(1,Nsegments)));
                road_type(1,Nsegments) = type_road;
                access_type(1,Nsegments) = type_access;
                                
                %add index of segment to outgoing indexlist of node
                temp_seg = parsed_nodes.outgoing_segments{A_pos(1,Nsegments)};
                temp_seg(1,size(temp_seg,2)+1)= Nsegments;
                parsed_nodes.outgoing_segments{A_pos(1,Nsegments)} = temp_seg;
                
                Nsegments=Nsegments+1;  
                
                way_id(1,Nsegments) = parsed_ways.id(i);
                B(1,Nsegments) = parsed_ways.nd{1,i}(j);
                A(1,Nsegments) = parsed_ways.nd{1,i}(j+1);
                B_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j));
                A_pos(1,Nsegments) = find(parsed_nodes.id==parsed_ways.nd{1,i}(j+1));
                d(1,Nsegments) = d(1,Nsegments-1);
                road_type(1,Nsegments) = type_road;
                access_type(1,Nsegments) = type_access;
                
                %add index of segment to outgoing indexlist of node
                temp_seg = parsed_nodes.outgoing_segments{A_pos(1,Nsegments)};
                temp_seg(1,size(temp_seg,2)+1)= Nsegments;
                parsed_nodes.outgoing_segments{A_pos(1,Nsegments)} = temp_seg;
                Nsegments=Nsegments+1;
            end
        end     
    end

end
parsed_segments.way_id = way_id;
parsed_segments.start = A;
parsed_segments.end = B;
parsed_segments.start_pos = A_pos;
parsed_segments.end_pos = B_pos;
parsed_segments.distance = d;
parsed_segments.roadtype = road_type;
parsed_segments.access = access_type;


function [parsed_relation] = parse_relation(relation)
Nrelation = size(relation, 2);

id = zeros(1,Nrelation);
%member = cell(1, Nrelation);
%tag = cell(1, Nrelation);
for i = 1:Nrelation
    currelation = relation{i};
    
    curid = currelation.Attributes.id;
    id(1, i) = str2double(curid);
end

parsed_relation.id = id;
