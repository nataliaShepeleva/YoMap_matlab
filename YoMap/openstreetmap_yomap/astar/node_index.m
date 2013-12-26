function n_index = node_index(OPEN,nodeId)
    %This function returns the index of the location of a node in the list
    %OPEN
    %
    %   Copyright 2009-2010 The MathWorks, Inc.
    i=1;
    while(OPEN(i,2) ~= nodeId)
        i=i+1;
    end;
    n_index=i;
end