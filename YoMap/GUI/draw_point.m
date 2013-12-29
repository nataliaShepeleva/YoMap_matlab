function [ hand ] = draw_point(ax, x, y, P)
% point A
if P == 0 
    hold (ax, 'on')
    hand = plot(ax, x,y, 'o','MarkerEdgeColor','k','MarkerFaceColor','r', 'MarkerSize',10);
    hold (ax, 'off')
end
if P == 1 % point B
    hold (ax, 'on')
    hand = plot(ax, x,y, 'o','MarkerEdgeColor','k','MarkerFaceColor','g', 'MarkerSize',10);
    hold (ax, 'off')
end
if P == 3 % point C
end
    