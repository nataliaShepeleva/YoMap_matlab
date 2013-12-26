function new_row = insert_open(node_id,parent_id,hn,gn,fn)
%Function to Populate the OPEN LIST
%OPEN LIST FORMAT
 %------------------2----------3---------4------5---6-----------------------
 %IS ON LIST 1/0 |NodeId |ParentNodeId |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
%
%   Copyright 2009-2010 The MathWorks, Inc.
new_row=[1,8];
new_row(1,1)=1;
new_row(1,2)=node_id;
new_row(1,3)=parent_id;
new_row(1,4)=hn;
new_row(1,5)=gn;
new_row(1,6)=fn;

end