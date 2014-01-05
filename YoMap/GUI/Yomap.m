function varargout = Yomap(varargin)
% YOMAP MATLAB code for Yomap.fig
%      YOMAP, by itself, creates a new YOMAP or raises the existing
%      singleton*.
%
%      H = YOMAP returns the handle to a new YOMAP or the handle to
%      the existing singleton*.
%
%      YOMAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YOMAP.M with the given input arguments.
%
%      YOMAP('Property','Value',...) creates a new YOMAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Yomap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Yomap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Yomap

% Last Modified by GUIDE v2.5 05-Jan-2014 23:35:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Yomap_OpeningFcn, ...
                   'gui_OutputFcn',  @Yomap_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% End initialization code - DO NOT EDIT


% --- Executes just before Yomap is made visible.
function Yomap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Yomap (see VARARGIN)

% Choose default command line output for Yomap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%set(gca, 'Units', 'normalized', 'Position', [0, 0.1, 1, 1]);


%define global variables
global valueA;
global categoryA;
global poiA;
global hdotA;
global xA;
global yA;
global flag_point_A;
global resultA;

global valueB;
global categoryB;
global poiB;
global hdotB;
global xB;
global yB;
global flag_point_B;
global resultB;

global valueC;
global categoryC;
global poiC;
global hdotC;
global xC;
global yC;
global flag_point_C;
global resultC;

global radius;
global distance;
global transport;
global cat;

global parsed_osm;
global route;
global h;
global points;
global parsed_poi;
global map_img_filename;

valueA = '';
valueB = '';
valueC = '';
resultA.id = 0;
resultB.id = 0;
resultC.id = 0;

radius = 0;
distance = 0;
transport = 2;

flag_point_A = 0;
flag_point_B = 0;
flag_point_C = 0;
points = 0;
xA = 0;
yA = 0;
xB = 0;
yB = 0;
xC = 0;
yC = 0;

%draw a map
h = gca;
route = 0;

%   Path to dir where project is!
%   needed because of saving variables
%dir_path = 'E:\Developing\Vibot\SE\GIT\YoMap_matlab\YoMap';

dir_path = 'C:\Users\clu\Documents\GitHub\YoMap_matlab\YoMap';

openstreetmap_filename = 'LeCreusotWaysFF.osm';%'genoa.osm';
parsed_osm_filename = 'LeCreusotWaysFF.mat'; %'osm file with data';
map_img_filename = 'map40000.png'; % image file saved from online, if available
poi_filename = 'LeCreusot_POI.xml'; %'osm file with data';
parsed_poi_filename = 'LeCreusot_POI.mat'; %'osm file with data';

[parsed_osm, osm_xml] = parse_openstreetmap(dir_path,openstreetmap_filename,parsed_osm_filename,2);
[parsed_poi] = parse_poi_xml(dir_path,poi_filename,parsed_poi_filename,2);
cat = ['choose category', parsed_poi.category.name];
%hshowMap = show_map(h, bounds, map_img_filename);
%plot_way(h, parsed_osm, map_img_filename);
%set(handles.showMapBtn, 'Value', 1);
show_Map_Result(h, 1, 0, 0, 0, 0, 0, parsed_osm, parsed_poi, map_img_filename);
set(handles.showMapBtn, 'Value', 1);
set(handles.showMapBtn, 'String', 'Hide map');
set(handles.footBtn, 'Value', 1);

% UIWAIT makes Yomap wait for user response (see UIRESUME)
% uiwait(handles.map);


% --- Outputs from this function are returned to the command line.
function varargout = Yomap_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function timeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function timeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function userEnterA_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterA as text
%        str2double(get(hObject,'String')) returns contents of userEnterA as a double
global valueA;
global parsed_poi;
global xA;
global yA;
global hdotA;
global h;
global flag_point_A;
global resultA;
valueA = get(handles.userEnterA,'String');
resultA = get_poi_by_name_or_address(parsed_poi, valueA);
if resultA.id ~= 0
    xA = resultA.xy(1);
    yA = resultA.xy(2);
    if flag_point_A == 0
        hdotA = draw_point(h, xA, yA, 0);
        flag_point_A = 1;
    else
        delete(hdotA);
        hdotA = draw_point(h, xA, yA, 0);
        flag_point_A = 1;
    end
else
    xA = 0;
    yA = 0;
    warn(7);
    if flag_point_A == 1
        delete(hdotA);
        flag_point_A = 0;
    end
    set(handles.userEnterA,'String', '');
    valueA = '';
end



% --- Executes during object creation, after setting all properties.
function userEnterA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function userEnterB_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterB as text
%        str2double(get(hObject,'String')) returns contents of userEnterB as a double
global valueB;
global parsed_poi;
global xB;
global yB;
global hdotB;
global h;
global flag_point_B;
global resultB;
valueB = get(handles.userEnterB,'String');
resultB = get_poi_by_name_or_address(parsed_poi, valueB);
if resultB.id ~= 0
    xB = resultB.xy(1);
    yB = resultB.xy(2);
    if flag_point_B == 0
        hdotB = draw_point(h, xB, yB, 1);
        flag_point_B = 1;
    else
        delete(hdotB)
        hdotB = draw_point(h, xB, yB, 1);
        flag_point_B = 1;
    end
else
    xB = 0;
    yB = 0;
    warn(7);
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
    set(handles.userEnterB,'String', '');
    valueB = '';
end

% --- Executes during object creation, after setting all properties.
function userEnterB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in carBtn.
function carBtn_Callback(hObject, eventdata, handles)
% hObject    handle to carBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of carBtn
global transport;
if get(handles.carBtn, 'Value')
    set(handles.footBtn, 'Value', 0);
    transport = 1;
end


% --- Executes on button press in footBtn.
function footBtn_Callback(hObject, eventdata, handles)
% hObject    handle to footBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of footBtn
global transport;
if get(handles.footBtn, 'Value')
    set(handles.carBtn, 'Value', 0);
    transport = 2;
end



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in distanceBtn.
function distanceBtn_Callback(hObject, eventdata, handles)
% hObject    handle to distanceBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of distanceBtn




function maxDistance_Callback(hObject, eventdata, handles)
% hObject    handle to maxDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxDistance as text
%        str2double(get(hObject,'String')) returns contents of maxDistance as a double
global distance;
dist = get(handles.maxDistance, 'String');
k = size(str2num(dist));
if k(1) == 1
    distance = str2num(dist);
else
    distance = 0;
    warn(25);
    set(handles.maxDistance, 'String', '0');
end


% --- Executes during object creation, after setting all properties.
function maxDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in searchBtn.
function searchBtn_Callback(hObject, eventdata, handles)
% hObject    handle to searchBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global valueA;
global categoryA;
global poiA;
global hdotA;
global flag_point_A;
global resultA;

global valueB;
global categoryB;
global poiB;
global hdotB;
global flag_point_B;
global resultB;

global categoryC;
global flag_point_C;
global hdotC;
global resultC;

global h;
global radius;
global distance;
global transport
global xA;
global yA;
global xB;
global yB;
global xC;
global yC;
global parsed_osm; 
global route;
global points;
global map_img_filename;
global parsed_poi;

btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnCategory = get(handles.showCategoryBtn, 'Value');

set(handles.tInstrOne, 'String', '');
set(handles.tInstrTwo, 'String', '');
set(handles.tInstrThree, 'String', '');
set(handles.tInstrFour, 'String', '');

if get(handles.enterBtnA, 'Value') == 0 & get(handles.listBtnA, 'Value') == 0 & get(handles.mapBtnA, 'Value') == 0
    fA = 0;
    warn(9);
else
    fA = 1;
end
if strcmp(get(handles.panelB, 'Visible'), 'on') == 1
    if get(handles.enterBtnB, 'Value') == 0 & get(handles.listBtnB, 'Value') == 0 & get(handles.mapBtnB, 'Value') == 0
        fB = 0;
        warn(10);
    else
        fB = 1;
    end
end

if get(handles.radiusBtn, 'Value') == 0
    if get(handles.iteneraryBtn, 'Value') == 0
        % AB search
        if fA == 1
            if fB == 1
                if get(handles.enterBtnA, 'Value') == 1
                    if strcmp(valueA, '') == 0
                        pA = 1;
                    else
                        pA = 0;
                        warn(2);
                    end
                end
                if get(handles.listBtnA, 'Value') == 1
                    if categoryA ~= 1
                        if poiA ~= 1
                            pA = 1;
                        else
                            pA = 0;
                            warn(5);
                        end
                    else
                        pA = 0;
                        warn(4);
                    end 
                end
                if get(handles.mapBtnA, 'Value') == 1
                    if xA ~= 0 & yA ~= 0
                        pA = 1;
                    else
                        pA = 0;
                        if xA == 0
                            warn(13);
                        end
                        if yA == 0
                            warn(14);
                        end
                    end
                end
                if get(handles.enterBtnB, 'Value') == 1
                    if strcmp(valueB, '') == 0
                        pB = 1;
                    else
                        pB = 0;
                        warn(3);
                    end
                end
                if get(handles.listBtnB, 'Value') == 1
                    if categoryB ~= 1
                        if poiB ~= 1
                            pB = 1;
                        else
                            pB = 0;
                            warn(12);
                        end
                    else
                        pB = 0;
                        warn(11);
                    end 
                end
                if get(handles.mapBtnB, 'Value') == 1
                    if xB ~= 0 & yB ~= 0
                        pB = 1;
                    else
                        pB = 0;
                        if xB == 0
                            warn(15);
                        end
                        if yB == 0
                            warn(16);
                        end
                    end
                end
                
                if pA == 1 & pB == 1
                    if transport ~= 0
                        route = findShortestWayByPosition(parsed_osm,xA,yA,xB,yB,transport);
                        if route ~= 0
                            points = [xB xA; yB yA];
                            if resultA.id ~= 0
                                st1 = strcat('Name: ', resultA.name);
                                st2 = strcat('Address: ', resultA.address);
                                strA = strvcat('Start point', st1, st2);
                                set(handles.tInstrOne, 'String', strA);
                            else
                                st1 = strcat('X: ', num2str(xA));
                                st2 = strcat('Y: ', num2str(yA));
                                strA = strvcat('Start point', st1, st2);
                                set(handles.tInstrOne, 'String', strA);
                            end
                            if resultB.id ~= 0
                                st1 = strcat('Name: ', resultB.name);
                                st2 = strcat('Address: ', resultB.address);
                                strB = strvcat('End point', st1, st2);
                                set(handles.tInstrTwo, 'String', strB);
                            else
                                st1 = strcat('X: ', num2str(xB));
                                st2 = strcat('Y: ', num2str(yB));
                                strB = strvcat('End point', st1, st2);
                                set(handles.tInstrTwo, 'String', strB);
                            end
                            if transport == 1
                                st1 = 'Go by car';
                            end
                            if transport == 2
                                st1 = 'Go by foot';
                            end
                            dist = calc_distance_route(route);
                            st2 = strcat('Route distance: ', num2str(dist), ' km');
                            str = strvcat(st1, st2, 'Have a nice trip!');
                            set(handles.tInstrThree, 'String', str);
                             if flag_point_A == 1 
                                if flag_point_B == 1 
                                    delete(hdotA);
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotB = draw_point(h, xB,yB, 1);
                                else
                                    delete(hdotA);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0); 
                                end
                            else
                                if flag_point_B == 1
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotB = draw_point(h, xB,yB, 1); 
                                else
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                end
                             end
                        else
                             if flag_point_A == 1 
                                if flag_point_B == 1 
                                    delete(hdotA);
                                    delete(hdotB);
                                    show_Map_Result(h, btnMap, btnRoads, 0, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotB = draw_point(h, xB,yB, 1);
                                else
                                    delete(hdotA);
                                    show_Map_Result(h, btnMap, btnRoads, 0, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0); 
                                end
                             else
                                if flag_point_B == 1
                                    delete(hdotB);
                                    show_Map_Result(h, btnMap, btnRoads, 0, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotB = draw_point(h, xB,yB, 1); 
                                else
                                    show_Map_Result(h, btnMap, btnRoads, 0, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                end
                             end
                            warn(6);
                        end
                    else
                        warn(1);
                    end
                end
            end                 
        end
    else
       % itenerary search 
        if fA == 1
            if get(handles.enterBtnA, 'Value') == 1
                if strcmp(valueA, '') == 0
                    pA = 1;
                else
                    pA = 0;
                    warn(2);
                end
            end
            if get(handles.listBtnA, 'Value') == 1
                if categoryA ~= 1
                    if poiA ~= 1
                        pA = 1;
                    else
                        pA = 0;
                        warn(5);
                    end
                else
                    pA = 0;
                    warn(4);
                end 
            end
            if get(handles.mapBtnA, 'Value') == 1
                if xA ~= 0 & yA ~= 0
                    pA = 1;
                else
                    pA = 0;
                    if xA == 0
                        warn(13);
                    end
                    if yA == 0
                        warn(14);
                    end
                end
            end
            if get(handles.enterBtnB, 'Value') == 1
                if strcmp(valueB, '') == 0
                    pB = 1;
                else
                    pB = 0;
                    warn(3);
                end
            end
            if get(handles.listBtnB, 'Value') == 1
                if categoryB ~= 1
                    if poiB ~= 1
                        pB = 1;
                    else
                        pB = 0;
                        warn(12);
                    end
                else
                    pB = 0;
                    warn(11);
                end 
            end
            if get(handles.mapBtnB, 'Value') == 1
                if xB ~= 0 & yB ~= 0
                    pB = 1;
                else
                    pB = 0;
                    if xB == 0
                        warn(15);
                    end
                    if yB == 0
                        warn(16);
                    end
                end
            end
            
            if categoryC ~= 1
                pC = 1;
            else
                pC = 0;
                warn(26);
            end 
            
            if pA == 1 & pB == 1 & pC == 1
                if transport ~= 0
                   [route,points,resultC] = findShortestItinerary(parsed_osm,parsed_poi,xA,yA,xB,yB,categoryC-1,distance,transport);
                    s = size(route);
                    if s(2) > 1
                        xC = resultC.xy(1);
                        yC = resultC.xy(2);
                        if resultA.id ~= 0
                            st1 = strcat('Name: ', resultA.name);
                            st2 = strcat('Address: ', resultA.address);
                            strA = strvcat('Start point', st1, st2);
                            set(handles.tInstrOne, 'String', strA);
                        else
                            st1 = strcat('X: ', num2str(xA));
                            st2 = strcat('Y: ', num2str(yA));
                            strA = strvcat('Start point', st1, st2);
                            set(handles.tInstrOne, 'String', strA);
                        end
                        if resultB.id ~= 0
                            st1 = strcat('Name: ', resultB.name);
                            st2 = strcat('Address: ', resultB.address);
                            strB = strvcat('End point', st1, st2);
                            set(handles.tInstrTwo, 'String', strB);
                        else
                            st1 = strcat('X: ', num2str(xB));
                            st2 = strcat('Y: ', num2str(yB));
                            strB = strvcat('End point', st1, st2);
                            set(handles.tInstrTwo, 'String', strB);
                        end
                        if resultC.id ~= 0
                            st1 = strcat('Name: ', resultC.name);
                            st2 = strcat('Address: ', resultC.address);
                            strC = strvcat('Also visit', st1, st2);
                            set(handles.tInstrThree, 'String', strC);
                        end
                        if transport == 1
                            st1 = 'Go by car';
                        else
                            st1 = 'Go by foot';
                        end
                        dist = calc_distance_route(route);
                        st2 = strcat('Route distance: ', num2str(dist), ' km');
                        str = strvcat(st1, st2, 'Have a nice trip!');
                        set(handles.tInstrFour, 'String', str);
                        if flag_point_A == 1 
                            if flag_point_B == 1
                                if flag_point_C == 1  
                                    delete(hdotA);
                                    delete(hdotB);
                                    delete(hdotC);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotB = draw_point(h, xB,yB, 1);
                                    hdotC = draw_point(h, xC,yC, 3);
                                    flag_point_C = 1;
                                else
                                    delete(hdotA);
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotB = draw_point(h, xB,yB, 1);
                                    hdotC = draw_point(h, xC,yC, 3);
                                    flag_point_C = 1;
                                end
                            else
                                if flag_point_C == 1 
                                    delete(hdotA);
                                    delete(hdotC);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotC = draw_point(h, xC,yC, 3);  
                                else
                                    delete(hdotA);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0); 
                                    hdotC = draw_point(h, xC,yC, 3);
                                    flag_point_C = 1;
                                end
                            end
                        else
                            if flag_point_B == 1
                                if flag_point_C == 1 
                                    delete(hdotB);
                                    delete(hdotC);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotB = draw_point(h, xB,yB, 1);
                                    hdotC = draw_point(h, xC,yC, 3); 
                                else
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotB = draw_point(h, xB,yB, 1); 
                                    hdotC = draw_point(h, xC,yC, 3);
                                    flag_point_C = 1;
                                end
                            else
                                if flag_point_C == 1 
                                    delete(hdotC);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotC = draw_point(h, xC,yC, 3); 
                                else
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotC = draw_point(h, xC,yC, 3);
                                    flag_point_C = 1;
                                end
                            end
                        end
                        if distance == 0
                            warn(27);
                        end
                    else
                        if flag_point_A == 1 
                            if flag_point_B == 1
%                                 if flag_point_C == 1  
%                                     delete(hdotA);
%                                     delete(hdotB);
%                                     delete(hdotC);
%                                     set(handles.showWayBtn, 'Value', 1);
%                                     set(handles.showWayBtn, 'String', 'Hide way');
%                                     show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                     hdotA = draw_point(h, xA,yA, 0);
%                                     hdotB = draw_point(h, xB,yB, 1);
%                                     hdotC = draw_point(h, xC,yC, 3);
%                                     flag_point_C = 1;
%                                 else
                                    delete(hdotA);
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0);
                                    hdotB = draw_point(h, xB,yB, 1);
%                                     hdotC = draw_point(h, xC,yC, 3);
%                                     flag_point_C = 1;
%                                 end
                            else
%                                 if flag_point_C == 1 
%                                     delete(hdotA);
%                                     delete(hdotC);
%                                     set(handles.showWayBtn, 'Value', 1);
%                                     set(handles.showWayBtn, 'String', 'Hide way');
%                                     show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                     hdotA = draw_point(h, xA,yA, 0);
%                                     hdotC = draw_point(h, xC,yC, 3);  
%                                 else
                                    delete(hdotA);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotA = draw_point(h, xA,yA, 0); 
%                                     hdotC = draw_point(h, xC,yC, 3);
%                                     flag_point_C = 1;
%                                 end
                            end
                        else
                            if flag_point_C == 1
                                delete(hdotC);
                                flag_point_C == 0;
                            end
                            if flag_point_B == 1
%                                 if flag_point_C == 1 
%                                     delete(hdotB);
%                                     delete(hdotC);
%                                     set(handles.showWayBtn, 'Value', 1);
%                                     set(handles.showWayBtn, 'String', 'Hide way');
%                                     show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                     hdotB = draw_point(h, xB,yB, 1);
%                                     hdotC = draw_point(h, xC,yC, 3); 
%                                 else
                                    delete(hdotB);
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                    hdotB = draw_point(h, xB,yB, 1); 
%                                     hdotC = draw_point(h, xC,yC, 3);
%                                     flag_point_C = 1;
%                                 end
                            else
%                                 if flag_point_C == 1 
%                                     delete(hdotC);
%                                     set(handles.showWayBtn, 'Value', 1);
%                                     set(handles.showWayBtn, 'String', 'Hide way');
%                                     show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                     hdotC = draw_point(h, xC,yC, 3); 
%                                 else
                                    set(handles.showWayBtn, 'Value', 1);
                                    set(handles.showWayBtn, 'String', 'Hide way');
                                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                     hdotC = draw_point(h, xC,yC, 3);
%                                     flag_point_C = 1;
%                                 end
                            end
                        end
                        warn(6);
                     end
                else
                    warn(1);
                end
            end
        end
    end
else
    % radius search
    if fA == 1
            if get(handles.enterBtnA, 'Value') == 1
                if strcmp(valueA, '') == 0
                    pA = 1;
                else
                    pA = 0;
                    warn(2);
                end
            end
            if get(handles.listBtnA, 'Value') == 1
                if categoryA ~= 1
                    if poiA ~= 1
                        pA = 1;
                    else
                        pA = 0;
                        warn(5);
                    end
                else
                    pA = 0;
                    warn(4);
                end 
            end
            if get(handles.mapBtnA, 'Value') == 1
                if xA ~= 0 & yA ~= 0
                    pA = 1;
                else
                    pA = 0;
                    if xA == 0
                        warn(13);
                    end
                    if yA == 0
                        warn(14);
                    end
                end
            end

            if categoryC ~= 1
                    pC = 1;
            else
                pC = 0;
                warn(26);
            end 
            
            if pA == 1 & pC
                if transport ~= 0
                    [route,points,resultC] = findShortestWayInRadius(parsed_osm,parsed_poi,xA,yA,categoryC-1,radius,transport);
                    s = size(route);
                    if s(2) > 1
                      if resultA.id ~= 0
                                st1 = strcat('Name: ', resultA.name);
                                st2 = strcat('Address: ', resultA.address);
                                strA = strvcat('Start point', st1, st2);
                                set(handles.tInstrOne, 'String', strA);
                            else
                                st1 = strcat('X: ', num2str(xA));
                                st2 = strcat('Y: ', num2str(yA));
                                strA = strvcat('Start point', st1, st2);
                                set(handles.tInstrOne, 'String', strA);
                            end
                            if resultC.id ~= 0
                                st1 = strcat('Name: ', resultC.name);
                                st2 = strcat('Address: ', resultC.address);
                                strC = strvcat('End point', st1, st2);
                                set(handles.tInstrTwo, 'String', strC);
                            end
                            if transport == 1
                                st1 = 'Go by car';
                            else
                                st1 = 'Go by foot';
                            end
                            dist = calc_distance_route(route);
                            st2 = strcat('Route distance: ',  num2str(dist), ' km');
                            str = strvcat(st1, st2, 'Have a nice trip!');
                            set(handles.tInstrThree, 'String', str);
                         if flag_point_A == 1 
                            if flag_point_C == 1 
                                delete(hdotA);
                                delete(hdotC);
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                hdotA = draw_point(h, xA,yA, 0);
                                hdotC = draw_point(h, xC,yC, 1);
                            else
                                delete(hdotA);
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                hdotA = draw_point(h, xA,yA, 0); 
                                hdotC = draw_point(h, xC,yC, 1);
                                flag_point_C = 1;
                            end
                        else
                            if flag_point_C == 1
                                delete(hdotC);
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                hdotC = draw_point(h, xC,yC, 1); 
                            else
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                hdotC = draw_point(h, xC,yC, 1);
                                flag_point_C = 1;
                            end
                         end
                        if radius == 0
                            warn(27);
                        end
                    else
                        if flag_point_C == 1
                            delete(hdotC);
                            flag_point_C == 0;
                        end
                         if flag_point_A == 1 
%                             if flag_point_C == 1 
%                                 delete(hdotA);
%                                 delete(hdotC);
%                                 set(handles.showWayBtn, 'Value', 1);
%                                 show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                 hdotA = draw_point(h, xA,yA, 0);
%                                 hdotC = draw_point(h, xC,yC, 1);
%                             else
                                delete(hdotA);
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                                hdotA = draw_point(h, xA,yA, 0); 
%                                 hdotC = draw_point(h, xC,yC, 3);
%                                 flag_point_C = 1;
%                             end
                        else
%                             if flag_point_C == 1
%                                 delete(hdotC);
%                                 set(handles.showWayBtn, 'Value', 1);
%                                 show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                 hdotC = draw_point(h, xC,yC, 3); 
%                             else
                                set(handles.showWayBtn, 'Value', 1);
                                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                                 hdotC = draw_point(h, xC,yC, 3);
%                                 flag_point_C = 1;
%                             end
                         end
                         warn(6);
                    end
                else
                    warn(1);
                end
            end
            
    end
end


% --- Executes on button press in radiusBtn.
function radiusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to radiusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiusBtn
global cat;
global hdotC;
global hdotB;
global xC;
global yC;
global flag_point_C;
global flag_point_B;
global categoryC;

global xB;
global yB;
global categoryB;
global poiB;
global valueB;
global resultB;

if (get(handles.radiusBtn,'Value') == 1)
    set(handles.radiusSearch, 'Visible', 'on');
    set(handles.radiusSearch, 'String', '0');
    set(handles.maxDistance, 'Visible', 'off');
    set(handles.iteneraryBtn, 'Value', 0);
    if strcmp(get(handles.panelB, 'Visible'), 'on') == 1
        set(handles.panelB, 'Visible', 'off');
        
        set(handles.enterBtnB, 'Value', 0);
        enterBtnB_Callback(hObject, eventdata, handles);
        set(handles.listBtnB, 'Value', 0);
        listBtnB_Callback(hObject, eventdata, handles);
        set(handles.mapBtnB, 'Value', 0);
        mapBtnB_Callback(hObject, eventdata, handles);
        xB = 0;
        yB = 0;
        categoryB = 1;
        poiB = 1;
        valueB = '';
        resultB.id = 0;
        set(handles.userEnterB, 'String','');
        set(handles.categoryMenuB, 'Value',1);
        set(handles.poiMenuB, 'Value',1);
        set(handles.coordXB , 'String', '0');
        set(handles.coordYB , 'String', '0');   
    end
    if strcmp(get(handles.panelC, 'Visible'), 'off') == 1
        set(handles.panelC, 'Visible', 'on');
    end
    set(handles.swapBtn, 'Visible', 'off');
    set(handles.categoryMenuC,'Value', 1);
    set(handles.categoryMenuC,'String',cat);
    categoryC = 1;
    if flag_point_C == 1
        delete(hdotC);
        flag_point_C = 0;
        xC = 0;
        yC = 0;
    end
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
else
    set(handles.radiusSearch, 'Visible', 'off');
    if strcmp(get(handles.panelB, 'Visible'), 'off') == 1
        set(handles.panelB, 'Visible', 'on');
    end
    if strcmp(get(handles.panelC, 'Visible'), 'on') == 1
        set(handles.panelC, 'Visible', 'off');
    end      
    
    if flag_point_C == 1
        delete(hdotC);
        flag_point_C = 0;
    end
    xC = 0;
    yC = 0;
end


function radiusSearch_Callback(hObject, eventdata, handles)
% hObject    handle to radiusSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radiusSearch as text
%        str2double(get(hObject,'String')) returns contents of radiusSearch as a double
global radius;
rad = get(handles.radiusSearch, 'String');
k = size(str2num(rad));
if k(1) == 1
    radius = str2num(rad);
else
    radius = 0;
    warn(25);
    set(handles.radiusSearch, 'String', '0');
end


% --- Executes during object creation, after setting all properties.
function radiusSearch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiusSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showWayBtn.
function showWayBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showWayBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showWayBtn
global h;
global parsed_osm;
global route; 
global points;
global parsed_poi;
global map_img_filename;
global flag_point_A;
global flag_point_B;
global flag_point_C;
global hdotA;
global hdotB;
global hdotC;
global xA;
global xB;
global yA;
global yB;
global xC;
global yC;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btnCategory = get(handles.showCategoryBtn, 'Value');
flg = 0;

if get(handles.enterBtnA, 'Value') == 0 & get(handles.listBtnA, 'Value') == 0 & get(handles.mapBtnA, 'Value') == 0 & get(handles.enterBtnB, 'Value') == 0 & get(handles.listBtnB, 'Value') == 0 & get(handles.mapBtnB, 'Value') == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
end

if get(handles.showWayBtn, 'Value') == 1
    set(handles.showWayBtn,'String', 'Hide way');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
else
    set(handles.showWayBtn,'String', 'Show way');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
end 
    


% --- Executes on button press in showMapBtn.
function showMapBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showMapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showMapBtn
global h;
global parsed_osm;
global route; 
global points;
global parsed_poi;
global map_img_filename;
global flag_point_A;
global flag_point_B;
global flag_point_C;
global hdotA;
global hdotB;
global hdotC;
global xA;
global xB;
global yA;
global yB;
global xC;
global yC;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btnCategory = get(handles.showCategoryBtn, 'Value');

if get(handles.enterBtnA, 'Value') == 0 & get(handles.listBtnA, 'Value') == 0 & get(handles.mapBtnA, 'Value') == 0 & get(handles.enterBtnB, 'Value') == 0 & get(handles.listBtnB, 'Value') == 0 & get(handles.mapBtnB, 'Value') == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
end
    
if get(handles.showMapBtn, 'Value') == 1
    set(handles.showMapBtn, 'String', 'Hide map');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
else
    set(handles.showMapBtn, 'String', 'Show map');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
end


% --- Executes on button press in showRoadsBtn.
function showRoadsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showRoadsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showRoadsBtn
global h;
global parsed_osm;
global route; 
global points;
global parsed_poi;
global map_img_filename;
global flag_point_A;
global flag_point_B;
global flag_point_C;
global hdotA;
global hdotB;
global hdotC;
global xA;
global xB;
global yA;
global yB;
global xC;
global yC;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btnCategory = get(handles.showCategoryBtn, 'Value');

if get(handles.enterBtnA, 'Value') == 0 & get(handles.listBtnA, 'Value') == 0 & get(handles.mapBtnA, 'Value') == 0 & get(handles.enterBtnB, 'Value') == 0 & get(handles.listBtnB, 'Value') == 0 & get(handles.mapBtnB, 'Value') == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
end
    
if get(handles.showRoadsBtn, 'Value') == 1
    set(handles.showRoadsBtn, 'String', 'Hide roads'); 
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
else
    set(handles.showRoadsBtn, 'String', 'Show roads');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
end


% --- Executes on button press in layer4.
function layer4_Callback(hObject, eventdata, handles)
% hObject    handle to layer4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of layer4


% --- Executes on button press in enterBtnA.
function enterBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnA
global hdotA;
global categoryA;
global poiA;
global xA;
global yA;
global flag_point_A;
if get(handles.enterBtnA, 'Value') == 1
    set(handles.listBtnA, 'Value', 0);
    set(handles.mapBtnA, 'Value', 0);
    
    if get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
    else
            if get(handles.swapBtn, 'Value') == 0
                set(handles.swapBtn, 'Visible', 'on');
            end
    end
    
    
    if get(handles.showCategoryBtn, 'Value') == 1
        set(handles.showBtnA, 'Visible', 'on');
    else
        set(handles.showBtnA, 'Visible', 'off');
    end
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'on');
    set(handles.userEnterA, 'String', '');
    categoryA = 1;
    poiA = 1;
    xA = 0;
    yA = 0;
    
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off')
    if (get(handles.drawBtnA, 'Value') == 1)
        if flag_point_A == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            flag_point_A = 0;
            set(handles.drawBtnA, 'Value', 0);
        end
    end
    if flag_point_A == 1
        delete(hdotA);
        flag_point_A = 0;
    end
else
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
    set(handles.showBtnA, 'Visible', 'off')
    set(handles.swapBtn, 'Visible', 'off');
    if flag_point_A == 1
        delete(hdotA); 
        flag_point_A = 0;
    end
end



% --- Executes on button press in listBtnA.
function listBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnA
global hdotA;
global cat;
global xA;
global yA;
global flag_point_A;
if get(handles.listBtnA, 'Value')
    set(handles.enterBtnA, 'Value', 0);
    set(handles.mapBtnA, 'Value', 0);
    
    if get(handles.enterBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
    else
            if get(handles.swapBtn, 'Value') == 0
                set(handles.swapBtn, 'Visible', 'on');
            end
    end
    
    set(handles.categoryMenuA, 'Visible', 'on');
    set(handles.categoryMenuA,'Value', 1);
    set(handles.categoryMenuA,'String',cat);
    set(handles.poiMenuA, 'Visible', 'on');
    set(handles.poiMenuA,'Value', 1);
    set(handles.poiMenuA,'String','choose category first');
    xA = 0;
    yA = 0;
    
    set(handles.userEnterA, 'Visible', 'off');
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    if get(handles.showCategoryBtn, 'Value') == 1
        set(handles.showBtnA, 'Visible', 'on')
    else
        set(handles.showBtnA, 'Visible', 'off')
    end
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    if (get(handles.drawBtnA, 'Value') == 1)
        if flag_point_A == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            flag_point_A = 0;
            set(handles.drawBtnA, 'Value', 0);
        end
    end
    if flag_point_A == 1
         delete(hdotA);
         flag_point_A = 0;
    end
else
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off');
    
    set(handles.swapBtn, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.showBtnA, 'Visible', 'off');
    set(handles.userEnterA, 'String', '');
    if flag_point_A == 1
        delete(hdotA); 
        flag_point_A = 0;
    end
end

% --- Executes on button press in prefBtnA.
function mapBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnA
global hdotA;
global categoryA;
global poiA;
global flag_point_A;
global xA;
global yA;
if get(handles.mapBtnA, 'Value')
    set(handles.enterBtnA,  'Value', 0);
    set(handles.listBtnA,  'Value', 0);
    
    if get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
    else
            if get(handles.swapBtn, 'Value') == 0
                set(handles.swapBtn, 'Visible', 'on');
            end
    end
    
    set(handles.coordXA, 'Visible', 'on');
    set(handles.coordYA, 'Visible', 'on');
    set(handles.showBtnA, 'Visible', 'on');
    set(handles.drawBtnA, 'Visible', 'on');
    set(handles.tXA, 'Visible', 'on');
    set(handles.tYA, 'Visible', 'on');
    set(handles.coordXA, 'Enable', 'on');
    set(handles.coordYA, 'Enable', 'on');
    set(handles.coordXA, 'String', '0');
    set(handles.coordYA, 'String', '0');
    categoryA = 1;
    poiA = 1;
    xA = 0;
    yA = 0;
    if flag_point_A == 1
        delete(hdotA);
        flag_point_A = 0;
    end
    set(handles.categoryMenuA, 'Visible', 'off');
    set(handles.poiMenuA, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'off');
    
else
    set(handles.coordXA, 'Visible', 'off');
    set(handles.coordYA, 'Visible', 'off');
    set(handles.showBtnA, 'Visible', 'off');
    set(handles.drawBtnA, 'Visible', 'off');
    set(handles.tXA, 'Visible', 'off');
    set(handles.tYA, 'Visible', 'off');
    if (get(handles.drawBtnA, 'Value') == 1)
        if flag_point_A == 0
            set(handles.drawBtnA, 'Value', 0);
        else
            delete(hdotA);
            flag_point_A = 0;
            set(handles.drawBtnA, 'Value', 0);
        end
    end
    if flag_point_A == 1
        delete(hdotA);
        flag_point_A = 0;
    end
    set(handles.swapBtn, 'Visible', 'off');
    set(handles.userEnterA, 'Visible', 'on');
    set(handles.userEnterA, 'Enable', 'off');
    set(handles.userEnterA, 'String', '');
end


% --- Executes on button press in enterBtnB.
function enterBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to enterBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enterBtnB
global hdotB;
global categoryB;
global poiB;
global xB;
global yB;
global flag_point_B;
if get(handles.enterBtnB, 'Value') == 1
    set(handles.listBtnB, 'Value', 0);
    set(handles.mapBtnB, 'Value', 0);
    
     if get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnA, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
     else
            if get(handles.swapBtn, 'Value') == 0
                set(handles.swapBtn, 'Visible', 'on');
            end
    end
    
    if get(handles.showCategoryBtn, 'Value') == 1
        set(handles.showBtnB, 'Visible', 'on');
    else
        set(handles.showBtnB, 'Visible', 'off');
    end
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'on');
    set(handles.userEnterB, 'String', '');
    categoryB = 1;
    poiB = 1;
    xB = 0;
    yB = 0;
    
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off');
    if (get(handles.drawBtnB, 'Value') == 1)
        if flag_point_B == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            flag_point_B = 0;
            set(handles.drawBtnB, 'Value', 0);
        end
    end
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
else
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
    set(handles.showBtnB, 'Visible', 'off')
    set(handles.swapBtn, 'Visible', 'off');
    if flag_point_B == 1
        delete(hdotB); 
        flag_point_B = 0;
    end
end


% --- Executes on button press in listBtnB.
function listBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnB
global hdotB;
global cat;
global xB;
global yB;
global flag_point_B;
if get(handles.listBtnB, 'Value')
    set(handles.enterBtnB, 'Value', 0);
    set(handles.mapBtnB, 'Value', 0);
    
     if get(handles.enterBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
     else
            if get(handles.swapBtn, 'Value') == 0
                set(handles.swapBtn, 'Visible', 'on');
            end
    end
    
    set(handles.categoryMenuB, 'Visible', 'on');
    set(handles.categoryMenuB,'Value', 1);
    set(handles.categoryMenuB,'String',cat);
    set(handles.poiMenuB, 'Visible', 'on');
    set(handles.poiMenuB,'Value', 1);
    set(handles.poiMenuB,'String','choose category first');
    
    set(handles.userEnterB, 'Visible', 'off');
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    if get(handles.showCategoryBtn, 'Value') == 1
        set(handles.showBtnB, 'Visible', 'on');
    else
        set(handles.showBtnB, 'Visible', 'off');
    end
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    xB = 0;
    yB = 0;
    if (get(handles.drawBtnB, 'Value') == 1)
        if flag_point_B == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            flag_point_B = 0;
            set(handles.drawBtnB, 'Value', 0);
        end
    end
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
else
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off');
    
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
    set(handles.showBtnB, 'Visible', 'off');
    set(handles.swapBtn, 'Visible', 'off');
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
end


% --- Executes on button press in prefBtnB.
function mapBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to prefBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prefBtnB
global hdotB;
global categoryB;
global poiB;
global flag_point_B;
global xB;
global yB;
if get(handles.mapBtnB, 'Value')
    set(handles.enterBtnB,  'Value', 0);
    set(handles.listBtnB,  'Value', 0);
    
     if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 0 | get(handles.iteneraryBtn, 'Value') == 1 | get(handles.radiusBtn, 'Value') == 1
        if strcmp(get(handles.swapBtn, 'Visible'), 'on') == 1
            set(handles.swapBtn, 'Visible', 'off');
        end
     else
        if get(handles.swapBtn, 'Value') == 0
            set(handles.swapBtn, 'Visible', 'on');
        end
    end
    
    set(handles.coordXB, 'Visible', 'on');
    set(handles.coordYB, 'Visible', 'on');
    set(handles.showBtnB, 'Visible', 'on');
    set(handles.drawBtnB, 'Visible', 'on');
    set(handles.tXB, 'Visible', 'on');
    set(handles.tYB, 'Visible', 'on');
    set(handles.coordXB, 'Enable', 'on');
    set(handles.coordYB, 'Enable', 'on');
    set(handles.coordXB, 'String', '0');
    set(handles.coordYB, 'String', '0');
    categoryB = 1;
    poiB = 1;
    xB = 0;
    yB = 0;
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
    set(handles.categoryMenuB, 'Visible', 'off');
    set(handles.poiMenuB, 'Visible', 'off');
    set(handles.userEnterB, 'Visible', 'off');
    
else
    set(handles.coordXB, 'Visible', 'off');
    set(handles.coordYB, 'Visible', 'off');
    set(handles.showBtnB, 'Visible', 'off');
    set(handles.drawBtnB, 'Visible', 'off');
    set(handles.tXB, 'Visible', 'off');
    set(handles.tYB, 'Visible', 'off');
    if (get(handles.drawBtnB, 'Value') == 1)
        if flag_point_B == 0
            set(handles.drawBtnB, 'Value', 0);
        else
            delete(hdotB);
            flag_point_B = 0;
            set(handles.drawBtnB, 'Value', 0);
        end
    end
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
    set(handles.swapBtn, 'Visible', 'off');
    set(handles.userEnterB, 'Visible', 'on');
    set(handles.userEnterB, 'Enable', 'off');
    set(handles.userEnterB, 'String', '');
end


% --- Executes on button press in swapBtn.
function swapBtn_Callback(hObject, eventdata, handles)
% hObject    handle to swapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global parsed_poi;
global valueA;
global valueB;
global h;
global xA;
global yA;
global xB;
global yB;
global hdotA;
global hdotB;
global flag_point_A;
global flag_point_B;

global resultA;
global resultB;
global categoryA;
global categoryB;
global poiA;
global poiB;
global route;

if (get(handles.enterBtnA, 'Value') == 1 & get(handles.enterBtnB, 'Value') == 1)
    if flag_point_A == 1 
        if flag_point_B == 1
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            set(handles.userEnterA, 'String', valueB);
            set(handles.userEnterB, 'String', valueA);
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            k = resultA;
            resultA = resultB;
            resultB = k;
            
            if route == 0
                delete(hdotA);
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                hdotB = draw_point(h,xB,yB,1);
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        else
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            set(handles.userEnterA, 'String', valueB);
            set(handles.userEnterB, 'String', valueA);
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');

            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            k = resultA;
            resultA = resultB;
            resultB = k;
            if route == 0
                delete(hdotA);
                hdotB = draw_point(h,xB,yB,1);
                flag_point_A = 0;
                flag_point_B = 1;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        end
    else
        if flag_point_B == 1
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            set(handles.userEnterA, 'String', valueB);
            set(handles.userEnterB, 'String', valueA);
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');

            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            k = resultA;
            resultA = resultB;
            resultB = k;
            if route == 0
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                flag_point_A = 1;
                flag_point_B = 0;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        else
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            set(handles.userEnterA, 'String', valueB);
            set(handles.userEnterB, 'String', valueA);
            valueA = get(handles.userEnterA, 'String');
            valueB = get(handles.userEnterB, 'String');
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            k = resultA;
            resultA = resultB;
            resultB = k;
            
            if route ~= 0 
                searchBtn_Callback(hObject, eventdata, handles);
            end 
        end
    end
end


if (get(handles.listBtnA, 'Value') == 1 & get(handles.listBtnB, 'Value') == 1)
    numA = 0;
    numB = 0;
    if flag_point_A == 1 
        if flag_point_B == 1
            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');

            k = resultA;
            resultA = resultB;
            resultB = k;
            
            set(handles.categoryMenuA, 'Value', (resultA.cat_id+1));
            categoryA = resultA.cat_id+1;
            set(handles.poiMenuA,'Value', 1);

            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultA.cat_id)];
            set(handles.poiMenuA, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultA.name) == 1
                    num = i;
                end
            end 
            poiA = num;
            set(handles.poiMenuA, 'Value', num);
            
            set(handles.categoryMenuB, 'Value', (resultB.cat_id+1));
            categoryB = resultB.cat_id+1;
            set(handles.poiMenuB,'Value', 1);
            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultB.cat_id)];
            set(handles.poiMenuB, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultB.name) == 1
                    num = i;
                end
            end 
            poiB = num;
            set(handles.poiMenuB, 'Value', num);
            

            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');
            
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if route == 0
                delete(hdotA);
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                hdotB = draw_point(h,xB,yB,1);
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        else
            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');

            k = resultA;
            resultA = resultB;
            resultB = k;
            
            set(handles.categoryMenuA, 'Value', (resultA.cat_id+1));
            categoryA = resultA.cat_id+1;
            set(handles.poiMenuA,'Value', 1);
            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultA.cat_id)];
            set(handles.poiMenuA, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultA.name) == 1
                    num = i;
                end
            end 
            poiA = num;
            set(handles.poiMenuA, 'Value', num);
            
            set(handles.categoryMenuB, 'Value', (resultB.cat_id+1));
            categoryB = resultB.cat_id+1;
            set(handles.poiMenuB,'Value', 1);
            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultB.cat_id)];
            set(handles.poiMenuB, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultB.name) == 1
                    num = i;
                end
            end 
            poiB = num;
            set(handles.poiMenuB, 'Value', num);
            

            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');
            
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if route == 0
                delete(hdotA);
                hdotB = draw_point(h,xB,yB,1);
                flag_point_A = 0;
                flag_point_B = 1;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        end
    else
        if flag_point_B == 1
            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');

            k = resultA;
            resultA = resultB;
            resultB = k;
            
            set(handles.categoryMenuA, 'Value', (resultA.cat_id+1));
            categoryA = resultA.cat_id+1;
            set(handles.poiMenuA,'Value', 1);
            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultA.cat_id)];
            set(handles.poiMenuA, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultA.name) == 1
                    num = i;
                end
            end 
            poiA = num;
            set(handles.poiMenuA, 'Value', num);
            
            set(handles.categoryMenuB, 'Value', (resultB.cat_id+1));
            categoryB = resultB.cat_id+1;
            set(handles.poiMenuB,'Value', 1);
            poi_name = ['choose poi'; get_names_poi_by_category_id( parsed_poi,resultB.cat_id)];
            set(handles.poiMenuB, 'String', poi_name);
            for i = 1:1:size(poi_name)
                if strcmp(poi_name(i),resultB.name) == 1
                    num = i;
                end
            end 
            poiB = num;
            set(handles.poiMenuB, 'Value', num);
            

            categoryA = get(handles.categoryMenuA,'Value');
            categoryB = get(handles.categoryMenuB,'Value');
            poiA = get(handles.poiMenuA,'Value');
            poiB = get(handles.poiMenuB,'Value');
            
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if route == 0
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                flag_point_A = 1;
                flag_point_B = 0;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        end
    end
end


if (get(handles.mapBtnA, 'Value') == 1 & get(handles.mapBtnB, 'Value') == 1)
    if flag_point_A == 1 
        if flag_point_B == 1
            valuexA = get(handles.coordXA, 'String');
            valuexB = get(handles.coordXB, 'String');
            valueyA = get(handles.coordYA, 'String');
            valueyB = get(handles.coordYB, 'String');
            set(handles.coordXA, 'String', valuexB);
            set(handles.coordXB, 'String', valuexA);
            set(handles.coordYA, 'String', valueyB);
            set(handles.coordYB, 'String', valueyA);
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if resultA.id ~= 0
                if resultB.id ~= 0
                    k = resultA;
                    resultA = resultB;
                    resultB = k;
                end
            end
            
            if route == 0
                delete(hdotA);
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                hdotB = draw_point(h,xB,yB,1);
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        else
            valuexA = get(handles.coordXA, 'String');
            valuexB = get(handles.coordXB, 'String');
            valueyA = get(handles.coordYA, 'String');
            valueyB = get(handles.coordYB, 'String');
            set(handles.coordXA, 'String', valuexB);
            set(handles.coordXB, 'String', valuexA);
            set(handles.coordYA, 'String', valueyB);
            set(handles.coordYB, 'String', valueyA);
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if resultA.id ~= 0
                if resultB.id ~= 0
                    k = resultA;
                    resultA = resultB;
                    resultB = k;
                end
            end
            if route == 0
                delete(hdotA);
                hdotB = draw_point(h,xB,yB,1);
                flag_point_A = 0;
                flag_point_B = 1;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        end
    else
        if flag_point_B == 1
            valuexA = get(handles.coordXA, 'String');
            valuexB = get(handles.coordXB, 'String');
            valueyA = get(handles.coordYA, 'String');
            valueyB = get(handles.coordYB, 'String');
            set(handles.coordXA, 'String', valuexB);
            set(handles.coordXB, 'String', valuexA);
            set(handles.coordYA, 'String', valueyB);
            set(handles.coordYB, 'String', valueyA);
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if resultA.id ~= 0
                if resultB.id ~= 0
                    k = resultA;
                    resultA = resultB;
                    resultB = k;
                end
            end
            if route == 0
                delete(hdotB);
                hdotA = draw_point(h,xA,yA,0);
                flag_point_A = 1;
                flag_point_B = 0;
            else
                searchBtn_Callback(hObject, eventdata, handles);
            end
        else
            valuexA = get(handles.coordXA, 'String');
            valuexB = get(handles.coordXB, 'String');
            valueyA = get(handles.coordYA, 'String');
            valueyB = get(handles.coordYB, 'String');
            set(handles.coordXA, 'String', valuexB);
            set(handles.coordXB, 'String', valuexA);
            set(handles.coordYA, 'String', valueyB);
            set(handles.coordYB, 'String', valueyA);
            k = xA;
            xA = xB;
            xB = k;
            k = yA;
            yA = yB;
            yB = k;
            if resultA.id ~= 0
                if resultB.id ~= 0
                    k = resultA;
                    resultA = resultB;
                    resultB = k;
                end
            end
            if route ~= 0 
                searchBtn_Callback(hObject, eventdata, handles);
            end 
        end
    end
end


% --- Executes on key press with focus on timeSlider and none of its controls.
function timeSlider_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to timeSlider (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in enterBtnC.
% function enterBtnC_Callback(hObject, eventdata, handles)
% % hObject    handle to enterBtnC (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of enterBtnC
% global hdotC;
% global categoryC;
% global poiC;
% global xC;
% global yC;
% global flag_point_C;
% if get(handles.enterBtnC, 'Value') == 1
%     set(handles.listBtnC, 'Value', 0);
%     set(handles.mapBtnC, 'Value', 0);
%     if get(handles.showCategoryBtn, 'Value') == 1
%         set(handles.showBtnC, 'Visible', 'on')
%     else
%         set(handles.showBtnC, 'Visible', 'off')
%     end
%     set(handles.userEnterC, 'Visible', 'on');
%     set(handles.userEnterC, 'Enable', 'on');
%     set(handles.userEnterC, 'String', '');
%     categoryC = 1;
%     poiC = 1;
%     xC = 0;
%     yC = 0;
%     
%     set(handles.coordXC, 'Visible', 'off');
%     set(handles.coordYC, 'Visible', 'off');
%     set(handles.drawBtnC, 'Visible', 'off');
%     set(handles.tXC, 'Visible', 'off');
%     set(handles.tYC, 'Visible', 'off');
%     set(handles.categoryMenuC, 'Visible', 'off');
%     set(handles.poiMenuC, 'Visible', 'off')
%     if (get(handles.drawBtnC, 'Value') == 1)
%         if flag_point_C == 0
%             set(handles.drawBtnC, 'Value', 0);
%         else
%             delete(hdotC);
%             flag_point_C = 0;
%             set(handles.drawBtnC, 'Value', 0);
%         end
%     end
%     if flag_point_C == 1
%         delete(hdotC);
%         flag_point_C = 0;
%     end
% else
%     set(handles.userEnterC, 'Enable', 'off');
%     set(handles.userEnterC, 'String', '');
%     set(handles.showBtnC, 'Visible', 'off')
%     if flag_point_C == 1
%         delete(hdotC); 
%         flag_point_C = 0;
%     end
% end

% --- Executes on button press in listBtnC.
% function listBtnC_Callback(hObject, eventdata, handles)
% % hObject    handle to listBtnC (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of listBtnC
% global hdotC;
% global cat;
% global xC;
% global yC;
% global flag_point_C;
% if get(handles.listBtnC, 'Value')
%     set(handles.enterBtnC, 'Value', 0);
%     set(handles.mapBtnC, 'Value', 0);
%     
%     set(handles.categoryMenuC, 'Visible', 'on');
%     set(handles.categoryMenuC,'Value', 1);
%     set(handles.categoryMenuC,'String',cat);
%     set(handles.poiMenuC, 'Visible', 'on');
%     set(handles.poiMenuC,'Value', 1);
%     set(handles.poiMenuC,'String','choose category first');
%     xC = 0;
%     yC = 0;
%     
%     set(handles.userEnterC, 'Visible', 'off');
%     set(handles.coordXC, 'Visible', 'off');
%     set(handles.coordYC, 'Visible', 'off');
%     if get(handles.showCategoryBtn, 'Value') == 1
%         set(handles.showBtnC, 'Visible', 'on')
%     else
%         set(handles.showBtnC, 'Visible', 'off')
%     end
%     set(handles.drawBtnC, 'Visible', 'off');
%     set(handles.tXC, 'Visible', 'off');
%     set(handles.tYC, 'Visible', 'off');
%     if (get(handles.drawBtnC, 'Value') == 1)
%         if flag_point_C == 0
%             set(handles.drawBtnC, 'Value', 0);
%         else
%             delete(hdotC);
%             flag_point_C = 0;
%             set(handles.drawBtnC, 'Value', 0);
%         end
%     end
%     if flag_point_C == 1
%          delete(hdotC);
%          flag_point_C = 0;
%     end
% else
%     set(handles.categoryMenuC, 'Visible', 'off');
%     set(handles.poiMenuC, 'Visible', 'off')
%     
%     set(handles.userEnterC, 'Visible', 'on');
%     set(handles.userEnterC, 'Enable', 'off');
%     set(handles.showBtnC, 'Visible', 'off')
%     set(handles.userEnterC, 'String', '');
%     if flag_point_C == 1
%         delete(hdotC); 
%         flag_point_C = 0;
%     end
% end


% --- Executes on button press in prefBtnC.
% function mapBtnC_Callback(hObject, eventdata, handles)
% % hObject    handle to prefBtnC (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of prefBtnC
% global hdotC;
% global categoryC;
% global poiC;
% global flag_point_C;
% global xC;
% global yC;
% if get(handles.mapBtnC, 'Value')
%     set(handles.enterBtnC,  'Value', 0);
%     set(handles.listBtnC,  'Value', 0);
%     
%     set(handles.coordXC, 'Visible', 'on');
%     set(handles.coordYC, 'Visible', 'on');
%     set(handles.showBtnC, 'Visible', 'on')
%     set(handles.drawBtnC, 'Visible', 'on');
%     set(handles.tXC, 'Visible', 'on');
%     set(handles.tYC, 'Visible', 'on');
%     set(handles.coordXC, 'Enable', 'on');
%     set(handles.coordYC, 'Enable', 'on');
%     set(handles.coordXC, 'String', xC);
%     set(handles.coordYC, 'String', yC);
%     categoryC = 1;
%     poiC = 1;
%     xC = 0;
%     yC = 0;
%     if flag_point_C == 1
%         delete(hdotC);
%         flag_point_C = 0;
%     end
%     set(handles.categoryMenuC, 'Visible', 'off');
%     set(handles.poiMenuC, 'Visible', 'off')
%     set(handles.userEnterC, 'Visible', 'off');
%     
% else
%     set(handles.coordXC, 'Visible', 'off');
%     set(handles.coordYC, 'Visible', 'off');
%     set(handles.showBtnC, 'Visible', 'off');
%     set(handles.drawBtnC, 'Visible', 'off');
%     set(handles.tXC, 'Visible', 'off');
%     set(handles.tYC, 'Visible', 'off');
%     if (get(handles.drawBtnC, 'Value') == 1)
%         if flag_point_C == 0
%             set(handles.drawBtnC, 'Value', 0);
%         else
%             delete(hdotC);
%             flag_point_C = 0;
%             set(handles.drawBtnC, 'Value', 0);
%         end
%     end
%     if flag_point_C == 1
%         delete(hdotC);
%         flag_point_C = 0;
%     end
%     set(handles.userEnterC, 'Visible', 'on');
%     set(handles.userEnterC, 'Enable', 'off');
%     set(handles.userEnterC, 'String', '');
% end



% function userEnterC_Callback(hObject, eventdata, handles)
% % hObject    handle to userEnterC (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of userEnterC as text
% %        str2double(get(hObject,'String')) returns contents of userEnterC as a double
% global valueC;
% global parsed_poi;
% global xC;
% global yC;
% global hdotC;
% global h;
% global flag_point_C;
% global resultC;
% valueC = get(handles.userEnterC,'String')
% resultC = get_poi_by_name_or_address(parsed_poi, valueC)
% if resultC.id ~= 0
%     xC = resultC.xy(1);
%     yC = resultC.xy(2);
%     if flag_point_C == 0
%         hdotC = draw_point(h, xC, yC, 3);
%         flag_point_C = 1;
%     else
%         delete(hdotC)
%         hdotC = draw_point(h, xC, yC, 3);
%         flag_point_C = 1;
%     end
% else
%     xC = 0;
%     yC = 0;
%     warn(7);
%     if flag_point_C == 1
%         delete(hdotC);
%         flag_point_C = 0;
%     end
%     set(handles.userEnterC,'String', '');
%     valueC = '';
% end


% % --- Executes during object creation, after setting all properties.
% function userEnterC_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to userEnterC (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% --- Executes on key press with focus on distanceBtn and none of its controls.
function distanceBtn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to distanceBtn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in categoryMenuA.
function categoryMenuA_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuA
global categoryA;
global parsed_poi;
%contents = cellstr(get(hObject,'String'));
%categoryA = contents{get(hObject,'Value')};
categoryA = get(handles.categoryMenuA,'Value');
switch categoryA
    case 1
        set(handles.poiMenuA,'Value', 1);
        set(handles.poiMenuA,'String', 'choose category first');
    otherwise
        poi = ['choose poi'; get_names_poi_by_category_id( parsed_poi,categoryA-1)];
        set(handles.poiMenuA,'Value', 1);
        set(handles.poiMenuA,'String', poi);
end



% --- Executes during object creation, after setting all properties.
function categoryMenuA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupMenuB.
function categoryMenuB_Callback(hObject, eventdata, handles)
% hObject    handle to popupMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupMenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMenuB
global categoryB;
global parsed_poi;
%contents = cellstr(get(hObject,'String'));
%categoryA = contents{get(hObject,'Value')};
categoryB = get(handles.categoryMenuB,'Value');
switch categoryB
    case 1
        set(handles.poiMenuB,'Value', 1);
        set(handles.poiMenuB,'String', 'choose category first');
    otherwise
        poi = ['choose poi'; get_names_poi_by_category_id( parsed_poi,categoryB-1)];
        set(handles.poiMenuB,'Value', 1);
        set(handles.poiMenuB,'String', poi);
end


% --- Executes during object creation, after setting all properties.
function categoryMenuB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hidePanel.
function hidePanel_Callback(hObject, eventdata, handles)
% hObject    handle to hidePanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.hidePanel, 'Value')
    set(handles.uipanelMain, 'Visible', 'off');
    set(handles.uipanelInstr, 'Position', [0 0 1 0.075]);
    set(handles.hidePanel, 'Position', [0.928 0.074 0.071 0.049]);
    set(handles.hidePanel, 'String', 'Show all');
else
    set(handles.uipanelMain, 'Visible', 'on');
    set(handles.uipanelInstr, 'Position', [0 0.148 1 0.075]); 
    set(handles.hidePanel, 'Position', [0.928 0.224 0.071 0.049]);
    set(handles.hidePanel, 'String', 'Hide all');
end


% --- Executes on selection change in poiMenuA.
function poiMenuA_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuA
global poiA;
global h;
global xA;
global yA;
global hdotA;
global flag_point_A;
global parsed_poi;
global categoryA;
global resultA;
poiA = get(handles.poiMenuA,'Value');
if poiA-1 ~= 0
    resultA = get_poi_by_id_from_category_id(parsed_poi,categoryA-1, poiA-1);
    xA = resultA.xy(1);
    yA = resultA.xy(2);
else
    xA = 0;
    yA = 0;
end

if flag_point_A == 0
    hdotA = draw_point(h, xA, yA, 0);
    flag_point_A = 1;
else
    delete(hdotA)
    hdotA = draw_point(h, xA, yA, 0);
    flag_point_A = 1;
end

% --- Executes during object creation, after setting all properties.
function poiMenuA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function coordXA_Callback(hObject, eventdata, handles)
% hObject    handle to coordXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXA as text
%        str2double(get(hObject,'String')) returns contents of coordXA as a double
global xA;
st = get(handles.coordXA, 'String');
k = size(str2num(st));
if k(1) == 1
    if  4.40 < str2num(st) & str2num(st) < 4.46
        xA = str2num(st);
    else
        xA = 0;
        warn(19);
        set(handles.coordXA, 'String', '0');
    end
else
    xA = 0;
    warn(13);
    set(handles.coordXA, 'String', '0');
end


% --- Executes during object creation, after setting all properties.
function coordXA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYA_Callback(hObject, eventdata, handles)
% hObject    handle to coordYA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYA as text
%        str2double(get(hObject,'String')) returns contents of coordYA as a double
global yA;
st = get(handles.coordYA, 'String');
k = size(str2num(st));
if k(1) == 1
    if  46.721 < str2num(st) & str2num(st) < 46.817
        yA = str2num(st);
    else
        yA = 0;
        warn(20);
        set(handles.coordYA, 'String', '0');
    end
else
    yA = 0;
    warn(14);
    set(handles.coordYA, 'String', '0');
end

% --- Executes during object creation, after setting all properties.
function coordYA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showBtnA.
function showBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xA;
global yA;
global hdotA;
if (get(handles.drawBtnA, 'Value') == 1 & hdotA == 0)
    set(handles.drawBtnA, 'Value', 0);
end

x = num2str(xA);
y = num2str(yA);
set(handles.coordXA, 'String', x);
set(handles.coordYA, 'String', y);

if get(handles.drawBtnA, 'Value') == 1
    set(handles.drawBtnA, 'Value',0);
    drawBtnA_Callback(hObject, eventdata, handles);
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
else
    set(handles.drawBtnA, 'Value',1);
    drawBtnA_Callback(hObject, eventdata, handles);
end


% --- Executes on button press in drawBtnA.
function drawBtnA_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnA
global xA;
global yA;
global h;
global hdotA;
global flag_point_A ;

% resultA = get_poi_by_coordinates(parsed_poi, xA, yA)
if (get(handles.drawBtnA, 'Value') == 1)
    if flag_point_A == 1
        delete(hdotA);
        hdotA = draw_point(h, xA,yA, 0);
        flag_point_A = 1;
    else
        hdotA = draw_point(h, xA,yA, 0);
        flag_point_A = 1;
    end
end
if (get(handles.drawBtnA, 'Value') == 0)
    if flag_point_A == 1
        delete(hdotA);
        flag_point_A = 0;
    end
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterB as text
%        str2double(get(hObject,'String')) returns contents of userEnterB as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterC as text
%        str2double(get(hObject,'String')) returns contents of userEnterC as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterD as text
%        str2double(get(hObject,'String')) returns contents of userEnterD as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterE as text
%        str2double(get(hObject,'String')) returns contents of userEnterE as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of userEnterF as text
%        str2double(get(hObject,'String')) returns contents of userEnterF as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userEnterF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYF_Callback(hObject, eventdata, handles)
% hObject    handle to coordYF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYF as text
%        str2double(get(hObject,'String')) returns contents of coordYF as a double


% --- Executes during object creation, after setting all properties.
function coordYF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXF_Callback(hObject, eventdata, handles)
% hObject    handle to coordXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXF as text
%        str2double(get(hObject,'String')) returns contents of coordXF as a double


% --- Executes during object creation, after setting all properties.
function coordXF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnF.
function drawBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnF


% --- Executes on button press in showBtnF.
function showBtnF_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in listBtnF.
function togglebutton57_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnF


% --- Executes on selection change in poiMenuF.
function poiMenuF_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuF


% --- Executes during object creation, after setting all properties.
function poiMenuF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuF.
function categoryMenuF_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuF


% --- Executes during object creation, after setting all properties.
function categoryMenuF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYE_Callback(hObject, eventdata, handles)
% hObject    handle to coordYE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYE as text
%        str2double(get(hObject,'String')) returns contents of coordYE as a double


% --- Executes during object creation, after setting all properties.
function coordYE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXE_Callback(hObject, eventdata, handles)
% hObject    handle to coordXE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXE as text
%        str2double(get(hObject,'String')) returns contents of coordXE as a double


% --- Executes during object creation, after setting all properties.
function coordXE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnE.
function drawBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnE


% --- Executes on button press in showBtnE.
function showBtnE_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in listBtnE.
function togglebutton53_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnE


% --- Executes on selection change in poiMenuE.
function poiMenuE_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuE


% --- Executes during object creation, after setting all properties.
function poiMenuE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuE.
function categoryMenuE_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuE


% --- Executes during object creation, after setting all properties.
function categoryMenuE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYD_Callback(hObject, eventdata, handles)
% hObject    handle to coordYD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYD as text
%        str2double(get(hObject,'String')) returns contents of coordYD as a double


% --- Executes during object creation, after setting all properties.
function coordYD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXD_Callback(hObject, eventdata, handles)
% hObject    handle to coordXD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXD as text
%        str2double(get(hObject,'String')) returns contents of coordXD as a double


% --- Executes during object creation, after setting all properties.
function coordXD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnD.
function drawBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnD


% --- Executes on button press in showBtnD.
function showBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mapBtnD.
function mapBtnD_Callback(hObject, eventdata, handles)
% hObject    handle to mapBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mapBtnD


% --- Executes on button press in listBtnD.
function togglebutton49_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnD


% --- Executes on selection change in poiMenuD.
function poiMenuD_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuD


% --- Executes during object creation, after setting all properties.
function poiMenuD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuD.
function categoryMenuD_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuD


% --- Executes during object creation, after setting all properties.
function categoryMenuD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYC_Callback(hObject, eventdata, handles)
% hObject    handle to coordYC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYC as text
%        str2double(get(hObject,'String')) returns contents of coordYC as a double


% --- Executes during object creation, after setting all properties.
function coordYC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXC_Callback(hObject, eventdata, handles)
% hObject    handle to coordXC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXC as text
%        str2double(get(hObject,'String')) returns contents of coordXC as a double


% --- Executes during object creation, after setting all properties.
function coordXC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnC.
function drawBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnC
global xC;
global yC;
global h;
global hdotC;
global flag_point_C ;
%if (strcmp(get(handles.coordXA, 'String'),'') == 0 & strcmp(get(handles.coordYA, 'String'),'') == 0)
if (get(handles.drawBtnC, 'Value') == 1)
    if flag_point_C == 1
        delete(hdotC);
        hdotC = draw_point(h, xC,yC, 3);
        flag_point_C = 1;
    else
        hdotC = draw_point(h, xC,yC, 3);
        flag_point_C = 1;
    end
end
if (get(handles.drawBtnC, 'Value') == 0)
    if flag_point_C == 1
        delete(hdotC);
        flag_point_C = 0;
    end
end

% --- Executes on button press in showBtnC.
function showBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xC;
global yC;
global hdotC;
if (get(handles.drawBtnC, 'Value') == 1 & hdotC == 0)
    set(handles.drawBtnC, 'Value', 0);
end

x = num2str(xC);
y = num2str(yC);
set(handles.coordXC, 'String', x);
set(handles.coordYC, 'String', y);

if get(handles.drawBtnC, 'Value') == 1
    set(handles.drawBtnC, 'Value',0);
    drawBtnC_Callback(hObject, eventdata, handles);
    set(handles.drawBtnC, 'Value',1);
    drawBtnC_Callback(hObject, eventdata, handles);
else
    set(handles.drawBtnC, 'Value',1);
    drawBtnC_Callback(hObject, eventdata, handles);
end

% --- Executes on button press in listBtnC.
function togglebutton45_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnC


% --- Executes on selection change in poiMenuC.
function poiMenuC_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuC
global poiC;
global h;
global xC;
global yC;
global hdotC;
global flag_point_C;
global parsed_poi;
global categoryC;
global resultC;
poiC = get(handles.poiMenuC,'Value');
if poiC-1 ~= 0
    resultC = get_poi_by_id_from_category_id(parsed_poi,categoryC-1, poiC-1);
    xC = resultC.xy(1);
    yC = resultC.xy(2);
else
    xC = 0;
    yC = 0;
end

if flag_point_C == 0
    hdotC = draw_point(h, xC, yC, 3);
    flag_point_C = 1;
else
    delete(hdotC)
    hdotC = draw_point(h, xC, yC, 3);
    flag_point_C = 1;
end


% --- Executes during object creation, after setting all properties.
function poiMenuC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in categoryMenuC.
function categoryMenuC_Callback(hObject, eventdata, handles)
% hObject    handle to categoryMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categoryMenuC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categoryMenuC
global categoryC;
% global parsed_poi;
% 
categoryC = get(handles.categoryMenuC,'Value');
% switch categoryC
%     case 1
%         set(handles.poiMenuC,'Value', 1);
%         set(handles.poiMenuC,'String', 'choose category first');
%     otherwise
%         poi = ['choose poi'; get_names_poi_by_category_id( parsed_poi,categoryC-1)];
%         set(handles.poiMenuC,'Value', 1);
%         set(handles.poiMenuC,'String', poi);
% end

% --- Executes during object creation, after setting all properties.
function categoryMenuC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categoryMenuC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordYB_Callback(hObject, eventdata, handles)
% hObject    handle to coordYB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordYB as text
%        str2double(get(hObject,'String')) returns contents of coordYB as a double
global yB;
st = get(handles.coordYB, 'String');
k = size(str2num(st));
if k(1) == 1
    if  46.721 < str2num(st) & str2num(st) < 46.817
        yB = str2num(st);
    else
        yB = 0;
        warn(22);
        set(handles.coordYB, 'String', '0');
    end
else
    yB = 0;
    warn(16);
    set(handles.coordYB, 'String', '0');
end


% --- Executes during object creation, after setting all properties.
function coordYB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordYB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordXB_Callback(hObject, eventdata, handles)
% hObject    handle to coordXB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coordXB as text
%        str2double(get(hObject,'String')) returns contents of coordXB as a double
global xB;
st = get(handles.coordXB, 'String');
k = size(str2num(st));
if k(1) == 1
    if  4.40 < str2num(st) & str2num(st) < 4.46
        xB = str2num(st);
    else
        xB = 0;
        warn(21);
        set(handles.coordXB, 'String', '0');
    end
else
    xB = 0;
    warn(15);
    set(handles.coordXB, 'String', '0');
end

% --- Executes during object creation, after setting all properties.
function coordXB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordXB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawBtnB.
function drawBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to drawBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawBtnB
global xB;
global yB;
global h;
global hdotB;
global flag_point_B ;
%if (strcmp(get(handles.coordXA, 'String'),'') == 0 & strcmp(get(handles.coordYA, 'String'),'') == 0)
if (get(handles.drawBtnB, 'Value') == 1)
    if flag_point_B == 1
        delete(hdotB);
        hdotB = draw_point(h, xB,yB, 1);
        flag_point_B = 1;
    else
        hdotB = draw_point(h, xB,yB, 1);
        flag_point_B = 1;
    end
end
if (get(handles.drawBtnB, 'Value') == 0)
    if flag_point_B == 1
        delete(hdotB);
        flag_point_B = 0;
    end
end



% --- Executes on button press in showBtnB.
function showBtnB_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xB;
global yB;
global hdotB;
if (get(handles.drawBtnB, 'Value') == 1 & hdotB == 0)
    set(handles.drawBtnB, 'Value', 0);
end

x = num2str(xB);
y = num2str(yB);
set(handles.coordXB, 'String', x);
set(handles.coordYB, 'String', y);

if get(handles.drawBtnB, 'Value') == 1
    set(handles.drawBtnB, 'Value',0);
    drawBtnB_Callback(hObject, eventdata, handles);
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
        set(handles.drawBtnB, 'Value',0);
else
    set(handles.drawBtnB, 'Value',1);
    drawBtnB_Callback(hObject, eventdata, handles);
        set(handles.drawBtnB, 'Value',0);
end


% --- Executes on button press in listBtnB.
function togglebutton41_Callback(hObject, eventdata, handles)
% hObject    handle to listBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of listBtnB


% --- Executes on selection change in poiMenuB.
function poiMenuB_Callback(hObject, eventdata, handles)
% hObject    handle to poiMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poiMenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poiMenuB
global poiB;
global h;
global xB;
global yB;
global hdotB;
global flag_point_B;
global parsed_poi;
global categoryB;
global resultB;
poiB = get(handles.poiMenuB,'Value');
if poiB-1 ~= 0
    resultB = get_poi_by_id_from_category_id(parsed_poi,categoryB-1, poiB-1);
    xB = resultB.xy(1);
    yB = resultB.xy(2);
else
    xB = 0;
    yB = 0;
end

if flag_point_B == 0
    hdotB = draw_point(h, xB, yB, 1);
    flag_point_B = 1;
else
    delete(hdotB)
    hdotB = draw_point(h, xB, yB, 1);
    flag_point_B = 1;
end


% --- Executes during object creation, after setting all properties.
function poiMenuB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiMenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function showWayBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showWayBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in showCategoryBtn.
function showCategoryBtn_Callback(hObject, eventdata, handles)
% hObject    handle to showCategoryBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showCategoryBtn
global h;
global parsed_osm;
global route; 
global points;
global parsed_poi;
global map_img_filename;
global flag_point_A;
global flag_point_B;
global flag_point_C;
global hdotA;
global hdotB;
global hdotC;
global xA;
global xB;
global yA;
global yB;
global xC;
global yC;
btnMap = get(handles.showMapBtn, 'Value');
btnRoads = get(handles.showRoadsBtn, 'Value');
btnWay = get(handles.showWayBtn, 'Value');
btnCategory = get(handles.showCategoryBtn, 'Value');


if get(handles.enterBtnA, 'Value') == 0 & get(handles.listBtnA, 'Value') == 0 & get(handles.mapBtnA, 'Value') == 0 & get(handles.enterBtnB, 'Value') == 0 & get(handles.listBtnB, 'Value') == 0 & get(handles.mapBtnB, 'Value') == 0
    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
end
    
if get(handles.showCategoryBtn, 'Value') == 1
    set(handles.showCategoryBtn,'String', 'Hide category');
    
    if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1
        set(handles.showBtnA, 'Visible', 'on');
    end   
    if get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1
        set(handles.showBtnB, 'Visible', 'on');
    end
    
    set(handles.infBtn, 'Visible', 'on');
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
else
    set(handles.showCategoryBtn,'String', 'Show category'); 
    
    if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1
        set(handles.showBtnA, 'Visible', 'off');
    end
    if get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1
        set(handles.showBtnB, 'Visible', 'off'); 
    end
    
    set(handles.infBtn, 'Visible', 'off'); 
    
    if get(handles.iteneraryBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_B == 1
                if flag_point_C == 1  
                    delete(hdotA);
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3);
                    flag_point_C = 1;
                else
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotA);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotC = draw_point(h, xC,yC, 3);  
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        else
            if flag_point_B == 1
                if flag_point_C == 1 
                    delete(hdotB);
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            else
                if flag_point_C == 1 
                    delete(hdotC);
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotC = draw_point(h, xC,yC, 3); 
                else
                    show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                     hdotC = draw_point(h, xC,yC, 3);
%                     flag_point_C = 1;
                end
            end
        end
    end
    
    if get(handles.radiusBtn, 'Value') == 1
        if flag_point_A == 1 
            if flag_point_C == 1 
                delete(hdotA);
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0);
                hdotC = draw_point(h, xC,yC, 1);
            else
                delete(hdotA);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotA = draw_point(h, xA,yA, 0); 
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
        else
            if flag_point_C == 1
                delete(hdotC);
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                hdotC = draw_point(h, xC,yC, 1); 
            else
                show_Map_Result(h, btnMap, btnRoads, 1, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
%                 hdotC = draw_point(h, xC,yC, 1);
%                 flag_point_C = 1;
            end
         end
    end
    
    if get(handles.radiusBtn, 'Value') == 0 & get(handles.iteneraryBtn, 'Value') == 0
        if get(handles.enterBtnA, 'Value') == 1 | get(handles.listBtnA, 'Value') == 1 | get(handles.mapBtnA, 'Value') == 1 | get(handles.enterBtnB, 'Value') == 1 | get(handles.listBtnB, 'Value') == 1 | get(handles.mapBtnB, 'Value') == 1
            if flag_point_A == 1 
                if flag_point_B == 1
                    delete(hdotA);
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0);
                    hdotB = draw_point(h, xB,yB, 1);
                else
                    delete(hdotA);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotA = draw_point(h, xA,yA, 0); 
                end
            else
                if flag_point_B == 1
                    delete(hdotB);
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                    hdotB = draw_point(h, xB,yB, 1); 
                else
                    show_Map_Result(h, btnMap, btnRoads, btnWay, btnCategory, route,  points, parsed_osm, parsed_poi, map_img_filename);
                end
            end
        end
    end
    
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function [x, y] = map_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global parsed_poi;
global h;
global xA;
global yA;
global xB;
global yB;
global hdotA;
global hdotB;
global flag_point_A;
global flag_point_B;

global resultA;
global resultB;
global valueA;
global categoryA;
global poiA;
global valueB;
global categoryB;
global poiB;
global cat;

xACorrect = 0;
yACorrect = 0;
xBCorrect = 0;
yBCorrect = 0;

if (get(handles.showBtnA,'Value') == 1)
    pos = get(handles.mapDraw, 'currentpoint');% get mouse location on figure
    xA = pos(1, 1);
    yA = pos(1, 2);
    
    if 4.40 < xA & xA < 4.46
        xACorrect = 1;
    else
        xACorrect = 0;
        xA = 0;
        yA = 0;
        set(handles.showBtnA,'Value', 0);
        warn(19);
    end
    if 46.721 < yA & yA < 46.817
        yACorrect = 1;
    else
        yACorrect = 0;
        xA = 0;
        yA = 0;
        set(handles.showBtnA,'Value', 0);
        warn(20);
    end
    if xACorrect == 1 & yACorrect == 1
        resultA = get_poi_by_coordinates(parsed_poi, xA, yA);
        set(handles.showBtnA,'Value', 0);

        if (get(handles.showCategoryBtn,'Value') == 1)
            if (get(handles.enterBtnA, 'Value') == 1)
                if resultA.id ~= 0
                    set(handles.userEnterA, 'String', resultA.name);
                    valueA = resultA.name;
                    set(handles.showBtnA,'Value', 0);
                    showBtnA_Callback(hObject, eventdata, handles);
                    if flag_point_A == 0
                        hdotA = draw_point(h, xA, yA, 0);
                        flag_point_A = 1;
                    else
                        delete(hdotA)
                        hdotA = draw_point(h, xA, yA, 0);
                        flag_point_A = 1;
                    end
                else
                    xA = 0;
                    yA = 0;
                    warn(8);
                end
            end

            if (get(handles.listBtnA, 'Value') == 1)
                if resultA.id ~= 0
                   set(handles.categoryMenuA, 'Value', (resultA.cat_id+1));
                    set(handles.poiMenuA,'Value', 1);
                    categoryA = resultA.cat_id+1;
                    poi_name = get_names_poi_by_category_id( parsed_poi,resultA.cat_id);
                    set(handles.poiMenuA, 'String', poi_name);
                    for i = 1:1:size(poi_name)
                        if strcmp(poi_name(i),resultA.name) == 1
                            num = i;
                        end
                    end 
                    poiA = num;
                    set(handles.poiMenuA, 'Value', num);
                    set(handles.showBtnA,'Value', 0);
                    showBtnA_Callback(hObject, eventdata, handles);
                    if flag_point_A == 0
                        hdotA = draw_point(h, xA, yA, 0);
                        flag_point_A = 1;
                    else
                        delete(hdotA)
                        hdotA = draw_point(h, xA, yA, 0);
                        flag_point_A = 1;
                    end
                else
                    xA = 0;
                    yA = 0;
                    warn(8);
                    set(handles.categoryMenuA, 'Value', 1);
                    categoryMenuA_Callback(hObject, eventdata, handles);
                    set(handles.poiMenuA,'Value', 1);
                end
            end

            if (get(handles.mapBtnA, 'Value') == 1)
                    showBtnA_Callback(hObject, eventdata, handles);  
            end
        else
            if (get(handles.mapBtnA, 'Value') == 1)
                showBtnA_Callback(hObject, eventdata, handles);
            else
                if flag_point_A == 1
                    delete(hdotA);
                    flag_point_A = 0;
                end
            end
        end
    end
end



if (get(handles.showBtnB,'Value') == 1)
    pos = get(handles.mapDraw, 'currentpoint');% get mouse location on figure
    xB = pos(1, 1);
    yB = pos(1, 2);
    
    if 4.40 < xB & xB < 4.46
        xBCorrect = 1;
    else
        xBCorrect = 0;
        xB = 0;
        yB = 0;
        set(handles.showBtnB,'Value', 0);
        warn(21);
    end
    if 46.721 < yB & yB < 46.817
        yBCorrect = 1;
    else
        yBCorrect = 0;
        xB = 0;
        yB = 0;
        set(handles.showBtnB,'Value', 0);
        warn(22);
    end
    if xBCorrect == 1 & yBCorrect == 1
        resultB = get_poi_by_coordinates(parsed_poi, xB, yB);
        set(handles.showBtnB,'Value', 0);

        if (get(handles.showCategoryBtn,'Value') == 1)
            if (get(handles.enterBtnB, 'Value') == 1)
                if resultB.id ~= 0
                    set(handles.userEnterB, 'String', resultB.name);
                    valueB = resultB.name;
                    set(handles.showBtnB,'Value', 0);
                    showBtnB_Callback(hObject, eventdata, handles);
                    if flag_point_B == 0
                        hdotB = draw_point(h, xB, yB, 1);
                        flag_point_B = 1;
                    else
                        delete(hdotB)
                        hdotB = draw_point(h, xB, yB, 1);
                        flag_point_B = 1;
                    end
                else
                    xB = 0;
                    yB = 0;
                    warn(8);
                end
            end

            if (get(handles.listBtnB, 'Value') == 1)
                if resultB.id ~= 0
                   set(handles.categoryMenuB, 'Value', (resultB.cat_id+1));
                   categoryB = resultB.cat_id+1;
                    set(handles.poiMenuB,'Value', 1);
                    poi_name = get_names_poi_by_category_id( parsed_poi,resultB.cat_id);
                    set(handles.poiMenuB, 'String', poi_name);
                    for i = 1:1:size(poi_name)
                        if strcmp(poi_name(i),resultB.name) == 1
                            num = i;
                        end
                    end 
                    poiB = num;
                    set(handles.poiMenuB, 'Value', num);
                    set(handles.showBtnB,'Value', 0);
                    showBtnA_Callback(hObject, eventdata, handles);
                    if flag_point_B == 0
                        hdotB = draw_point(h, xB, yB, 1);
                        flag_point_B = 1;
                    else
                        delete(hdotB)
                        hdotB = draw_point(h, xB, yB, 1);
                        flag_point_B = 1;
                    end
                else
                    xB = 0;
                    yB = 0;
                    warn(8);
                    set(handles.categoryMenuB, 'Value', 1);
                    categoryMenuB_Callback(hObject, eventdata, handles);
                    set(handles.poiMenuB,'Value', 1);
                end
            end

            if (get(handles.mapBtnB, 'Value') == 1)
                    showBtnB_Callback(hObject, eventdata, handles);  
            end
        else
            if (get(handles.mapBtnB, 'Value') == 1)
                showBtnB_Callback(hObject, eventdata, handles);
            else
                if flag_point_B == 1
                    delete(hdotB);
                    flag_point_B = 0;
                end
            end
        end
    end
end


if (get(handles.infBtn,'Value') == 1)
    pos = get(handles.mapDraw, 'currentpoint');% get mouse location on figure
    xI = pos(1, 1);
    yI = pos(1, 2);
    
    if 4.40 < xI & xI < 4.46
        xICorrect = 1;
    else
        xICorrect = 0;
        xI = 0;
        yI = 0;
        warn(23);
    end
    if 46.721 < yI & yI < 46.817
        yICorrect = 1;
    else
        yICorrect = 0;
        xI = 0;
        yI = 0;
        warn(24);
    end
    if xICorrect == 1 & yICorrect == 1
        resultI = get_poi_by_coordinates(parsed_poi, xI, yI);
        if resultI.id ~= 0
            st1 = strcat('Name: ', resultI.name);
            st2 = strcat('Address: ', resultI.address);
            strI1 = strvcat('Point information', st1, st2);
            set(handles.tInstrOne, 'String', strI1);
            
            st4 = strcat('X: ', num2str(resultI.xy(2)));
            st5 = strcat('Y: ', num2str(resultI.xy(1)));
            strI2 = strvcat(st4, st5);
            set(handles.tInstrTwo, 'String', strI2);
            set(handles.tInstrThree, 'String', '');
            set(handles.tInstrFour, 'String', '');
        else
            warn(8);
        end  
    end
    set(handles.infBtn,'Value',0);
end




% --- Executes during object creation, after setting all properties.
function showBtnB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showBtnB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in deleteBtn.
function deleteBtn_Callback(hObject, eventdata, handles)
% hObject    handle to deleteBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hdotC;
global flag_point_C;
global xC;
global yC;
set(handles.panelC, 'Visible', 'off');      
set(handles.swapBtn, 'Visible', 'on');
set(handles.addPoint, 'Visible', 'on');
set(handles.deleteBtn, 'Visible', 'off');
if flag_point_C == 1
    delete(hdotC);
    flag_point_C = 0;
end
xC = 0;
yC = 0;
set(handles.categoryMenuC,'Value', 1);
    

% --- Executes during object creation, after setting all properties.
function listBtnA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in mapBtnC.
function mapBtnC_Callback(hObject, eventdata, handles)
% hObject    handle to mapBtnC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mapBtnC


% --- Executes on button press in iteneraryBtn.
function iteneraryBtn_Callback(hObject, eventdata, handles)
% hObject    handle to iteneraryBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iteneraryBtn
global cat;
global hdotC;
global xC;
global yC;
global flag_point_C;
global categoryC;

if (get(handles.iteneraryBtn,'Value') == 1)
    set(handles.radiusBtn, 'Value', 0);
    set(handles.maxDistance, 'Visible', 'on');
    set(handles.maxDistance, 'String', '0');
    set(handles.radiusSearch, 'Visible', 'off');
    
    if strcmp(get(handles.panelC, 'Visible'), 'off') == 1
        set(handles.panelC, 'Visible', 'on');
    end
    if strcmp(get(handles.panelB, 'Visible'), 'off') == 1
        set(handles.panelB, 'Visible', 'on');
    end
    set(handles.swapBtn, 'Visible', 'off');
    set(handles.categoryMenuC,'Value', 1);
    set(handles.categoryMenuC,'String',cat);
    categoryC = 1;
    if flag_point_C == 1
        delete(hdotC);
        flag_point_C = 0;
        xC = 0;
        yC = 0;
    end
else
    set(handles.radiusSearch, 'Visible', 'off'); 
    if strcmp(get(handles.panelC, 'Visible'), 'on') == 1
        set(handles.panelC, 'Visible', 'off');
    end      

    set(handles.maxDistance, 'Visible', 'off');
    if flag_point_C == 1
        delete(hdotC);
        flag_point_C = 0;
    end
    xC = 0;
    yC = 0;
end



% --- Executes during object creation, after setting all properties.
function showMapBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showMapBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over mapBtnA.
function mapBtnA_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mapBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in infBtn.
function infBtn_Callback(hObject, eventdata, handles)
% hObject    handle to infBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of infBtn


% --- Executes on button press in info.
function info_Callback(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

st2 = 'Thanks to OpenStreetMap for simplification of our lives.';
st5 = 'ViBOT8/MsCV5:';
st6 = 'Emre Ozan Alkan';
st7 = 'Oksana Hagen';
st8 = 'Klemen Istenic';
st9 = 'Natalia Shepeleva';
s = strvcat(st2, '  ' ,st5, st6, st7, st8, st9);
mesh = msgbox(s, 'About Youmap', 'help');


% --- Executes on button press in showBtnA.
function togglebutton94_Callback(hObject, eventdata, handles)
% hObject    handle to showBtnA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showBtnA
