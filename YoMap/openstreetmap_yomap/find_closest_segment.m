function [ iSeg, point_of_contact ] = find_closest_segment( parsed_nodes, parsed_segments,mode, p_x,p_y )
%FIND_CLOSEST_SEGMENT Summary of this function goes here
%   Detailed explanation goes here

%Get Position of all segments start and end points
A(1,:) = parsed_nodes.xy(1,parsed_segments.start_pos(:));
A(2,:) = parsed_nodes.xy(2,parsed_segments.start_pos(:));

B(1,:) = parsed_nodes.xy(1,parsed_segments.end_pos(:));
B(2,:) = parsed_nodes.xy(2,parsed_segments.end_pos(:));

C = repmat([p_x;p_y],1,size(A,2));

%Calculate vectors u and v
% calculation from http://notmagi.me/closest-point-on-line-aabb-and-obb-to-point/
BA = B-A;
CA = C-A;

t=(BA(1,:).*CA(1,:)+BA(2,:).*CA(2,:)) ./ (BA(1,:).*BA(1,:)+BA(2,:).*BA(2,:));

%set all points that have projection outside of segment to border point
t(t>1)=1;
t(t<0)=0;

%Find projected points
PP(1,:) = A(1,:)+t(1,:).*BA(1,:);
PP(2,:) = A(2,:)+t(1,:).*BA(2,:);

%calculate distance between point and projections
D(1,:) = 1:size(PP,2);
D(2,:) = calc_air_distance(PP(1,:),PP(2,:),C(1,:),C(2,:));
D(3,:) = parsed_segments.roadtype(1,:);
D(4,:) = parsed_segments.access(1,:);
%find segment with min distance - closest
sorted = sortrows(D',2);

%if car
if mode==1
    %less than footway
    sorted = sorted((sorted(:,3)<9 & sorted(:,4)==0));
elseif mode==2
    %if foot -less than steps
    sorted = sorted((sorted(:,3)<11 & sorted(:,4)==0));
end   

iSeg = sorted(1,:);

point_of_contact = [PP(1,iSeg);PP(2,iSeg)];


