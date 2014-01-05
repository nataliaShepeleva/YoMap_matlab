function warn(numb)
switch numb
    case 1 
        error = 'Please choose type of transport';
    case 2
        error = 'Enter name or address of A';
    case 3
        error = 'Enter name or address of B';
    case 4
        error = 'Choose the category of A';
    case 5
        error = 'Choose the point of interest of A';
    case 6
        error = 'Sorry, no path found';
    case 7
        error = 'Sorry, this object does not exist or written not correctly';
    case 8
        error = 'Sorry, try to be more precise';
    case 9 
        error = 'Choose any category for point A';
    case 10 
        error = 'Choose any category for point B';
    case 11
        error = 'Choose the category of B';
    case 12
        error = 'Choose the point of interest of B';
    case 13
        error = 'Coordinate X for point A is empty';
    case 14
        error = 'Coordinate Y for point A is empty';
    case 15
        error = 'Coordinate X for point B is empty';
    case 16
        error = 'Coordinate Y for point B is empty';
    case 17
        error = 'Coordinate X for point C is empty';
    case 18
        error = 'Coordinate Y for point C is empty';
    case 19
        error = 'Coordinate X for point A is out of range';
    case 20
        error = 'Coordinate Y for point A is out of range';
    case 21
        error = 'Coordinate X for point B is out of range';
    case 22
        error = 'Coordinate Y for point B is out of range';
    case 23
        error = 'Coordinate X C is out of range';
    case 24
        error = 'Coordinate Y is out of range';
    case 25
        error = 'Enter correct radius';
    case 26 
        error = 'Choose any category for point C';
    case 27
        error = 'Radius is choosen as default';
        
end

hand = errordlg(error, 'YoMap');