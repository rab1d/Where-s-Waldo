%function multimaker
sca; commandwindow; clear all; clc;


difficulty = 'VeryHard'

%initial inputs
gridsize = [100 100]; %how big each grid will be
rectsize = [40 10]; %how big rectangle in grid will be
num_grid = [40 40]; % # of grids in image   
        % Easy [10 10]
        % Medium [20 20]
        % Hard [30 30]
        %VeryHard [40 40]
count_rgb=zeros(1,3);


%% What is my current directory, and parent directory?
cd('C:\Users\Experimental PC\Dropbox\Arafat\Active Codes')
parent_dir = 'C:\Users\Experimental PC\Dropbox\Arafat';

for num_img = 34:100
    %the image is num_grids*gridsize pixels big
    xImgSize = gridsize(2)*num_grid(2);
    yImgSize = gridsize(1)*num_grid(1);
    
    %create image matrix
    img = zeros(yImgSize, xImgSize, 3);
    img = img + 255; %image is white
    
    %% target maker
    %choose random color and orientation for target
    tar_rgb = randi(3);
    tar_orient = round(rand);
    
    % %for debugging purposes
    % tar_rgb = 3;
    % tar_orient = 1;
    
    %choose random position on image for target grid
    targrid_row = round(rand*(num_grid(1)-1))+1;
    targrid_col = round(rand*(num_grid(2)-1))+1;
    
    % %for debugging purposes
    % targrid_row = 2;
    % targrid_col = 1;
    
    %calculate which row/col to change in the img matrix
    img_rowmin = 1+(targrid_row-1)*gridsize(1);
    img_rowmax = gridsize(1)*targrid_row;
    img_colmin = 1 + (targrid_col-1)*gridsize(2);
    img_colmax = gridsize(2)*targrid_col;
    
    istarget = 1; %this is for the target
    
    %call onemaker2 to make a grid with the target in it
    [grid, color] = onemaker(gridsize, rectsize, tar_rgb, tar_orient, istarget);
    
    %place target grid in correct position in matrix
    img(img_rowmin:img_rowmax, img_colmin:img_colmax, :) = grid;
    
    istarget = 0; %for the distractors
    %% distractor maker
    for whichrow = 1:num_grid(1);
        for whichcolumn = 1:num_grid(2);
            if whichrow ~= targrid_row || whichcolumn ~= targrid_col; %check if the same as target position
                
                %get grid matrix from onemaker2
                [grid, color] = onemaker2(gridsize, rectsize, tar_rgb, tar_orient, istarget);
                
                %get correct positions of grid in img matrix
                img_rowmin = 1+(whichrow-1)*gridsize(1);
                img_rowmax = gridsize(1)*whichrow;
                img_colmin = 1 + (whichcolumn-1)*gridsize(2);
                img_colmax = gridsize(2)*whichcolumn;
                
                %place grid in img
                img(img_rowmin:img_rowmax, img_colmin:img_colmax, :) = grid;
                
                count_rgb(color)=count_rgb(color)+1; %counts the number of red, blue, green distractors    
            end
        end

    end
    
    
    imgnumber = num2str(num_img);
    
    name = [parent_dir, '\Experiment Images\', difficulty '\', 'img_', imgnumber, '.jpg'];
    imwrite(img, name, 'jpg');
    
    file_name = [parent_dir , '\Experiment Images\', difficulty, '\', 'file_', imgnumber];
    save(file_name, 'img', 'num_grid', 'tar_orient', 'gridsize', 'rectsize', 'tar_rgb', 'targrid_col', 'targrid_row');
    
    
    fprintf('For img # %d you have %d reds %d greens %d blues. The target is %d \n', num_img, count_rgb(1), count_rgb(2), count_rgb(3), tar_rgb)
    count_rgb=zeros(1,3);
end

% %debugging purposes
% [ptr, screenRect]=Screen('OpenWindow', 0, [0 0 0], [200,200,800,800]);
% text = Screen('MakeTexture', ptr, img);
% % Screen('DrawTexture', ptr, text);
% Screen('DrawTexture', ptr, text, [], screenRect);
% Screen('Flip', ptr);
%
% [ptr, screenRect]=Screen('OpenWindow', 0, [0 0 0]);
% text = Screen('MakeTexture', ptr, img);
% % Screen('DrawTexture', ptr, text);
% Screen('DrawTexture', ptr, text, []);