function varargout = main_train(varargin)
% MAIN_TRAIN MATLAB code for main_train.fig
%      MAIN_TRAIN, by itself, creates a new MAIN_TRAIN or raises the existing
%      singleton*.
addpath('IrisRecognition-master','pca_face','Simple_FingerPrint_Matching','image_fusion');
%      H = MAIN_TRAIN returns the handle to a new MAIN_TRAIN or the handle to
%      the existing singleton*.
   
%      MAIN_TRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_TRAIN.M with the given input arguments.
%
%      MAIN_TRAIN('Property','Value',...) creates a new MAIN_TRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_train_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_train_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_train

% Last Modified by GUIDE v2.5 19-Jun-2019 14:32:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_train_OpeningFcn, ...
                   'gui_OutputFcn',  @main_train_OutputFcn, ...
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
 
% --- Executes just before main_train is made visible.
function main_train_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_train (see VARARGIN)

% Choose default command line output for main_train
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_train wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_train_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% Database Entries
if exist('database.mat', 'file') == 2
     data = load('database.mat');
    f = data.face;
    [r,c] = size(f);
    set(handles.text17,'String',strcat(num2str(r),' Entries' ));
    set(handles.edit2,'String',strcat(num2str(r+1)));
 else
     set(handles.text17,'String', 'No Data' );
     set(handles.edit2,'String', '1' );
end 
 

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
global train_dir;
train_dir = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select training database path' );


%% Adding IRIS
% Left IRIS
img_i_l = imread(strcat(train_dir,'\l','.bmp'));
axes(handles.axes13);
imshow(img_i_l);
% Left IRIS
img_i_r = imread(strcat(train_dir,'\r','.bmp'));
axes(handles.axes14);
imshow(img_i_r);

%% Adding FACE
% first face
img_f_1 = imread(strcat(train_dir,'\f',' (1)','.bmp'));
axes(handles.axes21);
imshow(img_f_1);
% Second Face   
img_f_2 = imread(strcat(train_dir,'\f',' (2)','.bmp'));
axes(handles.axes22);
imshow(img_f_2);
% Thired Face
img_f_3 = imread(strcat(train_dir,'\f',' (3)','.bmp'));
axes(handles.axes23);
imshow(img_f_3);
% Fourth Face
img_f_4 = imread(strcat(train_dir,'\f',' (4)','.bmp'));
axes(handles.axes24);
imshow(img_f_4);
% Fifth Face
img_f_5 = imread(strcat(train_dir,'\f',' (5)','.bmp'));
axes(handles.axes25);
imshow(img_f_5);

%% Adding Finger Print
% First Finger Print 
img_p_1 = imread(strcat(train_dir,'\p',' (1)','.bmp'));
axes(handles.axes26);
imshow(img_p_1);
% Second Finger Print    
img_p_2 = imread(strcat(train_dir,'\p',' (2)','.bmp'));
axes(handles.axes27);
imshow(img_p_2);
% Thired Finger Print 
img_p_3 = imread(strcat(train_dir,'\p',' (3)','.bmp'));
axes(handles.axes28);
imshow(img_p_3);
% Fourth Finger Print 
img_p_4 = imread(strcat(train_dir,'\p',' (4)','.bmp'));
axes(handles.axes29);
imshow(img_p_4);
% Fifth Finger Print 
img_p_5 = imread(strcat(train_dir,'\p',' (5)','.bmp'));
axes(handles.axes30);
imshow(img_p_5);

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
set(handles.edit4,'ForegroundColor', 'Blue' );
set(handles.edit4,'String',strcat('>>> Processing...' ));
% hObject    handle to pushbutton11 (see GCBO)

%% Face 
global train_dir;
parts = strsplit(train_dir, '\');
DirPart = parts{end};

img_f_1 = getimage(handles.axes21);
[f1] = example(img_f_1,DirPart);
fe_fa_1 = imresize(f1,[250,250]);

img_f_2 = getimage(handles.axes22);
[f2] = example(img_f_2,DirPart);
fe_fa_2 = imresize(f2,[250,250]);

f_12 = main_f(fe_fa_1,fe_fa_2);

img_f_3 = getimage(handles.axes23);
[f3] = example(img_f_3,DirPart);
fe_fa_3 = imresize(f3,[250,250]);

f_13 = main_f(f_12,fe_fa_3);

img_f_4 = getimage(handles.axes24);
[f4] = example(img_f_4,DirPart);
fe_fa_4 = imresize(f4,[250,250]);

f_14 = main_f(f_13,fe_fa_4);


img_f_5 = getimage(handles.axes25);
[f5] = example(img_f_5,DirPart);

fe_fa_5 = imresize(f5,[250,250]);
f_15 = main_f(f_14,fe_fa_5);

i = get(handles.edit2,'String');
imwrite(f_15,strcat('DB\',i,'\face_',i,'.bmp'));
%% IRIS 
 img_i_l = getimage(handles.axes13);
 gufe_ir_l = gen_compare(img_i_l);

 
 
 img_i_r = getimage(handles.axes14);
 gufe_ir_r = gen_compare(img_i_r);

 i_12 = main_f(imresize(gufe_ir_l,[250,250]),imresize(gufe_ir_r,[250,250]));
imwrite(i_12,strcat('DB\',i,'\iris_',i,'.bmp'));
 %% Finger Print
img_p_1 = getimage(handles.axes26);
fe_fp_1 = main_total(img_p_1);


img_p_2 = getimage(handles.axes27);
fe_fp_2 = main_total(img_p_2);

p_12= main_f(imresize(fe_fp_1,[250,250]),imresize(fe_fp_2,[250,250]));

img_p_3 = getimage(handles.axes28);
fe_fp_3 = main_total(img_p_3);

p_13= main_f(imresize(p_12,[250,250]),imresize(fe_fp_3,[250,250]));

img_p_4 = getimage(handles.axes29);
fe_fp_4 = main_total(img_p_4);

p_14= main_f(imresize(p_13,[250,250]),imresize(fe_fp_4,[250,250]));

img_p_5 = getimage(handles.axes30);
fe_fp_5 = main_total(img_p_5);

p_15= main_f(imresize(p_14,[250,250]),imresize(fe_fp_5,[250,250]));
imwrite(p_15,strcat('DB\',i,'\fp_',i,'.bmp'));

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Training Database In MAT File
if exist('database.mat', 'file') == 2
     % File exists.
     database_t = load('database.mat');
face_t = database_t.face;
iris_t = database_t.iris;
fp_t = database_t.fp;

 face_i{ 1} = f1;
 face_i{ 2} = f2;
 face_i{ 3} = f3;
 face_i{ 4} = f4;
 face_i{ 5} = f5;

face = [face_t;face_i];

iris_i{ 1} = gufe_ir_l;
iris_i{ 2} = gufe_ir_r;

iris = [iris_t;iris_i];

fp_i{ 1} = fe_fp_1;
fp_i{ 2} = fe_fp_2;
fp_i{ 3} = fe_fp_3;
fp_i{ 4} = fe_fp_4;
fp_i{ 5} = fe_fp_5;

fp = [fp_t;fp_i];


save('database.mat','face','iris','fp' );
else 
    face{ 1} = f1;
 face{ 2} = f2;
 face{ 3} = f3;
 face{ 4} = f4;
 face{ 5} = f5;
 
iris{ 1} = gufe_ir_l;
iris{ 2} = gufe_ir_r;


fp{ 1} = fe_fp_1;
fp{ 2} = fe_fp_2;
fp{ 3} = fe_fp_3;
fp{ 4} = fe_fp_4;
fp{ 5} = fe_fp_5;


save('database.mat','face','iris','fp' );
end    
%% Display Success
set(handles.edit4,'ForegroundColor', 'Green' );
set(handles.edit4,'String',strcat('>>> Registration Success With ID:',i));
