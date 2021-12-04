clearvars
close all
clc
load cameraParams_Normal.mat;
imgnum=2;
str1='./Data/raw_depth';
str2='.png';
str3='./Data/raw_IR';
str4='./Data/raw_rgb';
cx=cameraParams.PrincipalPoint(1);
cy=cameraParams.PrincipalPoint(2);
fx=cameraParams.FocalLength(1);
fy=cameraParams.FocalLength(2);
fullPathtoDepthimage=strcat(str1,num2str(imgnum),str2);
fullPathtoIRimage=strcat(str3,num2str(imgnum),str2);
fullPathtoRGBimage=strcat(str4,num2str(imgnum),str2);
test_IR_img=double(imread(fullPathtoIRimage));
test_rgb_img=imread(fullPathtoRGBimage);
test_img=double(imread(fullPathtoDepthimage))/1000;
test_img=medfilt2(test_img,[7 7]);
figure; imagesc(test_rgb_img)
title("input RGB image")
figure; imagesc(test_IR_img)
title("input IR image")
figure; imagesc(test_img)
title("input Depth map")

pC=depth2pts(test_img,cameraParams);
tic
gtnormals=calc_normals(pC,35);

xxx=gtnormals(:,:,2);
yyy=gtnormals(:,:,1);
zzz=gtnormals(:,:,3);
gtTime=toc;

sprintf("The execution time for the proposed method is: %f seconds",gtTime)
[gt_azimuth,gt_elevation,~] = cart2sph(xxx,yyy,zzz);

figure;imagesc(gt_elevation)
title("\theta image obtained from plane fitting approach")
figure;imagesc(gt_azimuth)
title("\phi image obtained from plane fitting approach")

points=pC.Location;
xx=points(:,:,1);
yy=points(:,:,2);
zz=points(:,:,3);


alpha=[5 6];   % two scales normal computation
Nx=zeros(size(test_img,1),size(test_img,2));
Ny=zeros(size(test_img,1),size(test_img,2));
Nz=zeros(size(test_img,1),size(test_img,2));
tic
for i=1:length(alpha)
    [ax,ay,az]=FNE(test_img,alpha(i),fx,fy,cx,cy);
    Nx=Nx+ax;
    Ny=Ny+ay;
    Nz=Nz+az;
end
myTime=toc;
myTime=myTime/length(alpha);

sprintf("The execution time for the proposed method is: %f seconds",myTime)

[my_azimuth,my_elevation,~] = cart2sph(Nx/length(alpha),Ny/length(alpha),Nz/length(alpha));


figure;imagesc(my_elevation)
title("\theta image obtained from the proposed approach")

figure;imagesc(my_azimuth)
title("\phi image obtained from the proposed approach")




