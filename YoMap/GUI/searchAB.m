function string = searchAB(xA, yA, xB, yB, mode)
global h;
    s1 = strcat('From point A: ', 'x=', num2str(xA), ' y=', num2str(yA));
    s2 = strcat('To point B: ', 'x=', num2str(xB), ' y=', num2str(yB));
    switch mode
        case 1
            s3 = 'Going by foot';
        case 2
            s3 = 'Going by car';
        case 3
            s3 = 'Going by bike';
        case 4
            s3 = 'Going by bus';
    end
    
   string =  strvcat('Finally your way:', s1, s2, s3, 'Have a nice trip! :)');
