function ptCloud = depth2pts(img,cameraParams)

cx=cameraParams.PrincipalPoint(1);
cy=cameraParams.PrincipalPoint(2);
fx=cameraParams.FocalLength(1);
fy=cameraParams.FocalLength(2);

img=double(img);
[m,n]=size(img);
[u,v]=meshgrid(1:n,1:m);
pts=zeros(m,n,3);
pts(:,:,3)=img;
pts(:,:,1)=(1/fx)*((u-cx).*img);
pts(:,:,2)=(1/fy)*((v-cy).*img);

ptCloud=pointCloud(pts);
end