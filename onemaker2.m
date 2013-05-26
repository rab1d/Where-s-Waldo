function [grid, color] = onemaker2(gridsize, rectsize, tar_rgb, tar_orient, istarget );
%one that makes all with random orientation

length = rectsize(1);
width = rectsize(2);

grid = zeros(gridsize(1),gridsize(2), 3);

box_constraint = 1;
center_constraint = [box_constraint + length/2, box_constraint + width/2];

if istarget == 1;
    color = tar_rgb;
    orientation = tar_orient;
elseif istarget == 0;
    %distractors must have at least one attribute common to the target
    %if the color is different the orientation must be same
    %if the orientation is the different the color must be same
    
    color = randi(3);
    if color==tar_rgb;
        orientation=1-tar_orient;
    elseif color~=tar_rgb;
        orientation=randi(2)-1;
    end
    
    
end

%choose random center such that rectangle is always within the bounds of
%the grid
switch orientation
    case 0 %horizontal
        yCenter = 5+(width/2) + round(rand*(gridsize(1)-width-10));
        xCenter = 5+(length/2) + round(rand*(gridsize(2)-length-10));
  
        xmin = xCenter - length/2;
        xmax = xCenter + length/2;
        ymin = yCenter - width/2;
        ymax = yCenter + width/2;
    case 1 %vertical
        xCenter = 5+(width/2) + round(rand*(gridsize(2)-width-10));
        yCenter = 5+(length/2) + round(rand*(gridsize(1)-length-10));
              
        ymin = yCenter - length/2;
        ymax = yCenter + length/2;
        xmin = xCenter - width/2;
        xmax = xCenter + width/2;
end
grid(xmin:xmax, ymin:ymax, color) = 255;





