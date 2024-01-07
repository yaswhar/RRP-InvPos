% Yashar Zafari - 99106209 - Robotics Homework 3
function [ theta1 , theta2 , d] = RRP_InvPos( pos )
pos = round (pos , 3);
L1 =310;
L2 =300;
theta1=atan2d(-pos(1,:),pos(2,:));
theta2=atan2d((pos(3,:)-L1).*sind(theta1+90),pos(2,:));
% Singularity check
id=abs(theta1)==0;
theta2(~id)=atan2d((pos(3,~id)-L1).*cosd(theta1(~id)+90),pos(1,~id));
d=(pos(3,:)-L1)./sind(theta2)-L2;
% Singularity and logicality check
singindx = isnan(d) | d<0;
d(singindx)=pos(2,singindx)./(cosd(theta2(singindx)).*sind(theta1(singindx)+90))-L2;
% Singularity and locicality check - again
remsingindx= (isnan(d) | d<0) & theta2~=90;
theta2(remsingindx)=atan2d((pos(3,remsingindx)-L1).*cosd(theta1(remsingindx)+90),pos(1,remsingindx))+180;
d(remsingindx)=pos(1,remsingindx)./(cosd(theta2(remsingindx)).*cosd(theta1(remsingindx)+90))-L2;
remsingindx= isnan(d) | d<0;
d(remsingindx)=pos(1,remsingindx)./(cosd(theta2(remsingindx)).*sind(theta1(remsingindx)+90))-L2;
theta1=round(theta1,3);
theta2=round(theta2,3);
d=round(d,3);
end
