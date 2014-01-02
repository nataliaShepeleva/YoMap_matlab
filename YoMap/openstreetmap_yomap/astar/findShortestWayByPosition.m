function [ Optimal_path ] = findShortestWayByPosition( parsed_osm,start_x,start_y,end_x,end_y,mode)
%FINDSHORTESTWAY Summary of this function goes here
%   parsed_osm - data about roads
%   start_x - start x coordinate
%   start_y - start y coordinate
%   end_x - start x coordinate
%   end_y - start y coordinate
%   mode - type of transportation (1-car, 2-foot)
%   RETURN: 
%   Optimal_path - optimal path (from last to first point)

    [iS_start,pointOfContact_start] = find_closest_segment(parsed_osm.node,parsed_osm.segments,mode,start_x,start_y);
    [iS_end,pointOfContact_end] = find_closest_segment(parsed_osm.node,parsed_osm.segments,mode,end_x,end_y);

    nNodes = size(parsed_osm.node.id,2);
    nSegments = size(parsed_osm.segments.way_id,2)+1;

    %Add fake node for start point
    parsed_osm.node.id(nNodes+1) = 0;
    parsed_osm.node.xy(:,nNodes+1) = pointOfContact_start;
    
    parsed_osm.node.id(nNodes+2) = 1;
    parsed_osm.node.xy(:,nNodes+2) = pointOfContact_end;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%SNAP START POINT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Add fake connections from start point to nodes of closest segment
    wayID = parsed_osm.segments.way_id(iS_start);
    wayPos = find(parsed_osm.way.id(:)==wayID);
    [key tg] = get_way_tags(parsed_osm.way.tag{1,wayPos});
    flag_start_segment_oneway=0;
    ind=find(ismember(key,{'oneway'}));
    if ~isempty(ind)
        if strcmp(val(1,ind), 'yes') | strcmp(val(1,ind), '-1')
            flag_start_segment_oneway=1;
            %only segment from start to B
            parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
            parsed_osm.segments.start(nSegments) = 0;
            parsed_osm.segments.end(nSegments) = parsed_osm.segments.end(iS_start);
            parsed_osm.segments.start_pos(nSegments) = nNodes+1;
            parsed_osm.segments.end_pos(nSegments) = parsed_osm.segments.end_pos(iS_start);
            parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+1,parsed_osm.segments.end_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_start);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_start);    
            temp_seg(1,1)= nSegments;
            parsed_osm.node.outgoing_segments{nNodes+1} = temp_seg;
        end
    end
    if flag_start_segment_oneway==0
        %START-> SegmentPoint B
        parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
        parsed_osm.segments.start(nSegments) = 0;
        parsed_osm.segments.end(nSegments) = parsed_osm.segments.end(iS_start);
        parsed_osm.segments.start_pos(nSegments) = nNodes+1;
        parsed_osm.segments.end_pos(nSegments) = parsed_osm.segments.end_pos(iS_start);
        parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+1,parsed_osm.segments.end_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_start);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_start);
        
        temp_seg(1,1)= nSegments;
        nSegments = nSegments+1;

        %Start -> SegmentPoint A
        parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
        parsed_osm.segments.start(nSegments) = 0;
        parsed_osm.segments.end(nSegments) = parsed_osm.segments.start(iS_start);
        parsed_osm.segments.start_pos(nSegments) = nNodes+1;
        parsed_osm.segments.end_pos(nSegments) = parsed_osm.segments.start_pos(iS_start);
        parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+1,parsed_osm.segments.end_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_start);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_start);

        temp_seg(1,2)= nSegments;
        parsed_osm.node.outgoing_segments{nNodes+1} = temp_seg;
        nSegments = nSegments+1;
    end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%SNAP END POINT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %Add fake connections from end node segments to end point
    wayID = parsed_osm.segments.way_id(iS_end);
    wayPos = find(parsed_osm.way.id(:)==wayID);
    [key val] = get_way_tags(parsed_osm.way.tag{1,wayPos});
    flag_end_segment_oneway=0;
    ind=find(ismember(key,{'oneway'}));
    if ~isempty(ind)
        if (strcmp(val(1,ind), 'yes') || strcmp(val(1,ind), '-1'))
            flag_end_segment_oneway=1;
            %only segment from start to B
            parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
            parsed_osm.segments.start(nSegments) = parsed_osm.segments.start(iS_end);
            parsed_osm.segments.end(nSegments) = 1;
            parsed_osm.segments.start_pos(nSegments) = parsed_osm.segments.start_pos(iS_end);
            parsed_osm.segments.end_pos(nSegments) = nNodes+2;
            parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+2,parsed_osm.segments.start_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_end);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_end);
            
            temp_seg = parsed_osm.node.outgoing_segments{parsed_osm.segments.start_pos(iS_end)};
            temp_seg(1,size(temp_seg,2)+1)= nSegments;
            parsed_osm.node.outgoing_segments{parsed_osm.segments.start_pos(iS_end)} = temp_seg;
            nSegments = nSegments+1;            
        end
    end
    if flag_end_segment_oneway==0
        
        %START-> SegmentPoint B
        parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
        parsed_osm.segments.start(nSegments) = parsed_osm.segments.start(iS_end);
        parsed_osm.segments.end(nSegments) = 1;
        parsed_osm.segments.start_pos(nSegments) = parsed_osm.segments.start_pos(iS_end);
        parsed_osm.segments.end_pos(nSegments) = nNodes+2;
        parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+2,parsed_osm.segments.start_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_end);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_end);
        
        temp_seg = parsed_osm.node.outgoing_segments{parsed_osm.segments.start_pos(iS_end)};
        temp_seg(1,size(temp_seg,2)+1)= nSegments;
        parsed_osm.node.outgoing_segments{parsed_osm.segments.start_pos(iS_end)} = temp_seg;
        nSegments = nSegments+1;
        
        %Start -> SegmentPoint A
        parsed_osm.segments.way_id(nSegments) = parsed_osm.segments.way_id(wayPos);
        parsed_osm.segments.start(nSegments) = parsed_osm.segments.end(iS_end);
        parsed_osm.segments.end(nSegments) = 1;
        parsed_osm.segments.start_pos(nSegments) = parsed_osm.segments.end_pos(iS_end);
        parsed_osm.segments.end_pos(nSegments) = nNodes+2;
        parsed_osm.segments.distance(nSegments) = calc_air_distance_byID(parsed_osm.node,nNodes+2,parsed_osm.segments.start_pos(nSegments));
            parsed_osm.segments.roadtype(nSegments) = parsed_osm.segments.roadtype(iS_end);
            parsed_osm.segments.access(nSegments) = parsed_osm.segments.access(iS_end);
        
        temp_seg = parsed_osm.node.outgoing_segments{parsed_osm.segments.end_pos(iS_end)};
        temp_seg(1,size(temp_seg,2)+1)= nSegments;
        parsed_osm.node.outgoing_segments{parsed_osm.segments.end_pos(iS_end)} = temp_seg;
        
    end
  
Optimal_path = findShortestWay(parsed_osm,mode,0,1);
