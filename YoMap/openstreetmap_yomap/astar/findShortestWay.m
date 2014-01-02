function [ Optimal_path ] = findShortestWay( parsed_osm,mode,startNodeID, targetNodeID )
%FINDSHORTESTWAY Summary of this function goes here
%   parsed_osm - data about roads
%   mode - type of transportation (1-car, 2-foot)
%   startNodeID - start node in parsed osm
%   targetNodeID - end node in parsed osm
%   RETURN: 
%   Optimal_path - optimal path (from last to first point)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN LIST STRUCTURE
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
%--------------------------------------------------------------------------
OPEN=[];
%CLOSED LIST STRUCTURE
%--------------
%X val | Y val |
%--------------
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];
CLOSED_COUNT=0;

%set index of nodes
startNode = find(parsed_osm.node.id==startNodeID);
targetNode = find(parsed_osm.node.id==targetNodeID);

%set the starting node as the first node
currentNode = startNode;
OPEN_COUNT=1;
path_cost=0;
%goal_distance=distance(xNode,yNode,xTarget,yTarget);
goal_distance = calc_air_distance_byID(parsed_osm.node,startNode,targetNode);
OPEN(OPEN_COUNT,:)=insert_open(startNode,startNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=startNode;
NoPath=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((currentNode ~= targetNode) && NoPath == 1)
    exp_array=expand_array(parsed_osm,mode,currentNode,path_cost,targetNode,CLOSED);
    exp_count=size(exp_array,1);

 %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %------------------2----------3---------4------5---6-----------------------
 %IS ON LIST 1/0 |NodeId |ParentNodeId |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|NeighNodeId ||h(n) |g(n)|f(n)|
 %--------------------------------
 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2))
            OPEN(j,6)=min(OPEN(j,6),exp_array(i,4)); %#ok<*SAGROW>
            if OPEN(j,6)== exp_array(i,4)
                %UPDATE PARENTS,gn,hn
                OPEN(j,3)=currentNode;
                OPEN(j,4)=exp_array(i,2);
                OPEN(j,5)=exp_array(i,3);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),currentNode,exp_array(i,2),exp_array(i,3),exp_array(i,4));
     end;%End of insert new element into the OPEN list
 end;%End of i for

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_COUNT,targetNode);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   currentNode=OPEN(index_min_node,2);
   path_cost=OPEN(index_min_node,4);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=currentNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path


i=size(CLOSED,1);
Optimal_path=[];
valNode=CLOSED(i,1);
i=1;
%Optimal_path(i,1)=valNode;
Optimal_path(:,i)=parsed_osm.node.xy(:,valNode);
i=i+1;

if ( (valNode == targetNode))
   %Traverse OPEN and determine the parent nodes
   parent_node=OPEN(node_index(OPEN,valNode),3);%node_index returns the index of the node
   
   while( parent_node ~= startNode)
           %Optimal_path(i,1) = parent_node;
           Optimal_path(:,i)=parsed_osm.node.xy(:,parent_node);
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_node);
           parent_node=OPEN(inode,3);%node_index returns the index of the node
           i=i+1;
    end;
    Optimal_path(:,i)=parsed_osm.node.xy(:,startNode);

end

