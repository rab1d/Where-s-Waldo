function [grid, color] = onemaker_white(gridsize, rectsize, tar_rgb, tar_orient, istarget );

% % debugging purposes
% sca; commandwindow; clear all;
% % initial input
% gridsize = [100 100];
% rectsize = [20 10]; %length by width
% istarget = 0;

length = rectsize(1);
width = rectsize(2);

grid = zeros(gridsize(1),gridsize(2), 3);
%grid = grid + 255; %matrix is white

% if istarget == 1;
%     color = tar_rgb;
%     orientation = tar_orient;
% elseif istarget == 0;
%     while 1
%         color = 1+round(rand*2); %random color chooser
%         orientation = round(rand); %1=horizontal, 0=vertical
%         if color ~= tar_rgb || orientation ~= tar_orient %either color or orientation must be different
%             break
%         end
%     end
% end

if istarget == 1;
    color = tar_rgb;
    orientation = tar_orient;
elseif istarget == 0;
%distractors must have at least one attribute common to the target
%if the color is different the orientation must be same
%if the orientation is the different the color must be same
    while 1
        color = 1+round(rand*2); %random color chooser
        if color == tar_rgb ;
            orientation = 1 - tar_orient;
        else orientation = tar_orient;
        end

        if color ~= tar_rgb || orientation ~= tar_orient %either color or orientation must be different
            break
        end
    end
end



%choose random center such that rectangle is always within the bounds of
%the grid
switch orientation
    case 0 %horizontal
        yCenter = 1+(width/2) + round(rand*(gridsize(1)-width-1));
        xCenter = 1+(length/2) + round(rand*(gridsize(2)-length-1));
        xmin = xCenter - length/2;
        xmax = xCenter + length/2;
        ymin = yCenter - width/2;
        ymax = yCenter + width/2;
    case 1 %vertical
        xCenter = 1+(width/2) + round(rand*(gridsize(2)-width-1));
        yCenter = 1+(length/2) + round(rand*(gridsize(1)-length-1));
        ymin = yCenter - length/2;
        ymax = yCenter + length/2;
        xmin = xCenter - width/2;
        xmax = xCenter + width/2;
end
grid(xmin:xmax, ymin:ymax, color) = 255;


% %debugging purposes
% [ptr, screenRect]=Screen('OpenWindow', 0, [0 0 0], [600 600 800 800]);
% img = Screen('MakeTexture', ptr, grid);
% Screen('DrawTexture', ptr, img);
% Screen('Flip', ptr);



