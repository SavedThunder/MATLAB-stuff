function varargout = First_GUI(varargin)
% FIRST_GUI MATLAB code for First_GUI.fig
%      FIRST_GUI, by itself, creates a new FIRST_GUI or raises the existing
%      singleton*.
%
%      H = FIRST_GUI returns the handle to a new FIRST_GUI or the handle to
%      the existing singleton*.
%
%      FIRST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRST_GUI.M with the given input arguments.
%
%      FIRST_GUI('Property','Value',...) creates a new FIRST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before First_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to First_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help First_GUI

% Last Modified by GUIDE v2.5 16-Mar-2016 08:22:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @First_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @First_GUI_OutputFcn, ...
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


% --- Executes just before First_GUI is made visible.
function First_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to First_GUI (see VARARGIN)
%The Opening Function Sets up how FirstGui looks it is first opened

axes(handles.axes1);  % Point to the top plot tagged as axes1
% Plot a 1 Hz sine wave with amplitude of 5
t = 0:1e-6:1; y = 5*sin(2*pi*t);
plot(t,y); axis([0 1 -10 10]);

axes(handles.axes2);  % Point to the bottom plot tagged as axes2
% Plot a 1 Hz cosine wave with amplitude of 1
t = -1:0.001:1; y = cos(2*pi*t); plot(t,y); title('cos(2*pi*t)');
% Choose default command line output for First_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes First_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = First_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in GraphMenu.
function GraphMenu_Callback(hObject, eventdata, handles)
% hObject    handle to GraphMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns GraphMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from GraphMenu
% This will read the selection from the popup menu and plot the indicated function
axes(handles.axes2);    % Makes axes2 the selected plot window
cla;                    % Clears axes2

menu_choice = get(handles.GraphMenu, 'Value');  % Get user choice from pop-up menu tagged as menu1
switch menu_choice
    case 1
        t = -1:0.001:1; y = cos(2*pi*t); plot(t,y); title('cos(2*pi*t)');
    case 2
        t = -2*pi:0.001:2*pi; y = tan(t); 
        plot(t,y); axis([-2*pi 2*pi -10 10]); title('tan(t)');
    case 3
        t = 0.1:0.001:5; y = log(t);
        plot(t,y); title('ln(t)');
end

% --- Executes during object creation, after setting all properties.
function GraphMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FreqBox_Callback(hObject, eventdata, handles)
% hObject    handle to FreqBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FreqBox as text
%        str2double(get(hObject,'String')) returns contents of FreqBox as a double
%This function will retrieve the value a user enters in for frequency.  If
%the frequency entered is not a number, it will be set the value to one and user
%will be prompted to enter a number.

freq = str2double(get(handles.FreqBox,'String'));   % Get the frequency from box tagged FreqBox
if isnan(freq)                               % If freq isn't a number over-write it with a 1
    freq = 1;
    set(handles.FreqBox, 'String',1);        % Write a 1 into the box
    errordlg('Input must be a number');      % Tell user to put in a number
    pause(2);
end

amp = get(handles.AmpSlider,'Value');    % Get amplitude from Slider tagged AmpSlider

axes(handles.axes1);    %Select axes1 for plotting
cla;                    %Clear out axes 1

t = 0:1e-6:1;
y = amp*sin(2*pi*freq*t);
plot(t,y); axis([0 1 -10 10]);

% --- Executes during object creation, after setting all properties.
function FreqBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FreqBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function AmpSlider_Callback(hObject, eventdata, handles)
% hObject    handle to AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
amp = get(handles.AmpSlider, 'Value');    % Get the new slider value

freq = str2double(get(handles.FreqBox,'String'));  % Get frequency from box tagged FreqBox

axes(handles.axes1);    %Select axes1 for plotting
cla;                    %Clear out axes 1

t = 0:1e-6:1;
y = amp*sin(2*pi*freq*t);
plot(t,y); axis([0 1 -10 10]);

set(handles.AmpBox, 'String',amp);  % Writes value of slider into box tagged AmpBox

% --- Executes during object creation, after setting all properties.
function AmpSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
