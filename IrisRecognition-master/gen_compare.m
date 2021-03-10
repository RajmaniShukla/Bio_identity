function temp2 = gen_compare(filename)
%filename = 'D:\New folder (2)\Matlab\bin\bio\new\IrisRecognition-master\1\left\aeval1_direct.jpg';
addpath('D:\New folder (2)\Matlab\bin\bio\new\IrisRecognition-master\1\left');
fig=imread(strcat(filename));

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=fig;
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp2 th tv]=gen_templateVVV(parr);
