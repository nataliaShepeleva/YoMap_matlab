function exp_array=expand_array(parsed_osm,mode,currentNode,hn,targetNode,CLOSED)
    %Function to return an expanded array
    %This function takes a node and returns the expanded list
    %of successors,with the calculated fn values.
    %The criteria being none of the successors are on the CLOSED list.
    %
    %   Copyright 2009-2010 The MathWorks, Inc.
    
    exp_array=[];
    exp_count=1;
    
    cur_outgoing_conn = parsed_osm.node.outgoing_segments{currentNode};
    Nconnections = size(cur_outgoing_conn,2);
    for k= 1:Nconnections
        segment_id = cur_outgoing_conn(k);
        if parsed_osm.segments.access(segment_id)==0 && (mode == 0 || ((mode==1 && parsed_osm.segments.roadtype(segment_id)<9) || (mode==2 && parsed_osm.segments.roadtype(segment_id<11))))
           %if access is any AND mode is car and road is caravaliable or
           %mode is foot and road is also foot avaliable
           id_nodeB = parsed_osm.segments.end_pos(segment_id);
            if isempty(find(CLOSED==id_nodeB,1))
                exp_array(exp_count,1) = id_nodeB;
                exp_array(exp_count,2) = hn+parsed_osm.segments.distance(segment_id);%cost of travelling to node
                exp_array(exp_count,3) = calc_air_distance_byID(parsed_osm.node,targetNode,id_nodeB);%distance between node and goal
                exp_array(exp_count,4) = exp_array(exp_count,2)+exp_array(exp_count,3);%fn
                exp_count=exp_count+1;
            end
        end

    end%End of k for loop    