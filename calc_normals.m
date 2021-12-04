function out = calc_normals(pts_in,nsize)
sensorCenter = [0,0,0];
normals_vec=pcnormals(pts_in,nsize);

if (ndims( pts_in.Location)==3)
    x = pts_in.Location(:,:,1);
    y = pts_in.Location(:,:,2);
    z = pts_in.Location(:,:,3);
    u = normals_vec(:,:,1);
    v = normals_vec(:,:,2);
    w = normals_vec(:,:,3);
else
    x = pts_in.Location(:,1);
    y = pts_in.Location(:,2);
    z = pts_in.Location(:,3);
    u = normals_vec(:,1);
    v = normals_vec(:,2);
    w = normals_vec(:,3);
end




for k = 1 : numel(x)
    p1 = sensorCenter - [x(k),y(k),z(k)];
    p2 = [u(k),v(k),w(k)];
    % Flip the normal vector if it is not pointing towards the sensor.
    angle = atan2(norm(cross(p1,p2)),p1*p2');
    if angle > pi/2 || angle < -pi/2
        u(k) = -u(k);
        v(k) = -v(k);
        w(k) = -w(k);
    end
end
if (ndims( pts_in.Location)==3)
    
    out=cat(3,-u,-v,-w);
else
    out=cat(2,-u,-v,-w);
end
end

