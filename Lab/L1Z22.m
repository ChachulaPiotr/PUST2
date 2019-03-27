% clear all;
% H=figure;
% fullImage = imread('big.jpg');
% imshow(fullImage);

[y,x] = ginput(2);
x=floor(x);
y=floor(y);

if x(2)>x(1)
    xmin=x(1);
    xmax=x(2);
else
    xmin=x(2);
    xmax=x(1);
end

if y(2)>y(1)
    ymin=y(1);
    ymax=y(2);
else
    ymin=y(2);
    ymax=y(1);
end


if (x(1)<0)||(x(2)<0)||(y(1)<0)||(y(2)<0)
    disp('Punkt poza granicami rysunku');
end

% userImage=fullImage(xmin:xmax,ymin:ymax,:);
% size_x=xmax-xmin+1;
% size_y=ymax-ymin+1;
% 
% contrast=getContrast(userImage);
% 
% H=gui(userImage,size_x,size_y);