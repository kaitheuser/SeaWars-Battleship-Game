% Created by Kai Chuen Tan.
% Inspired by OSU EED.

start = 1;
while start == 1
    clear all; clc; close all;
    checkComplete = 0;
    violate = 0;

    [y1, f1] =audioread('SWOPJW.mp3');
    sound(y1, f1);
    SeaWars = imread('SeaWarsV2.png');
    imshow(SeaWars);
    title('Sea Wars Battlefront II')

    while true

        % Mouse Input from User
        [User_Row, User_Column] = ginput(1);

        % If Start, then let's the game begin.
        if User_Row >= 157 && User_Row <= 261 && User_Column <= 383 && User_Column >= 358
            start = 1;
            [y2, f2] =audioread('LS.mp3');
            sound(y2, f2);
            pause(1)
            clear sound;
            break;
        % If Home, then goodbye.
        elseif User_Row >= 431 && User_Row <= 532 && User_Column <= 382 && User_Column >= 357
            start = 0;
            [y3, f3] =audioread('LS.mp3');
            sound(y3, f3);
            pause(1)
            clear sound;
            break;
        % Else do nothing.
        end

    end

    close all
    
    if start == 0
        break;
    end

    
    [y4, f4] =audioread('SWBSJW.mp3');
    sound(y4, f4);

    instruction = imread('INST.png');
    imshow(instruction);
    title('Instructions')

    while true

        % Mouse Input from User
        [User_Row, User_Column] = ginput(1);

        % If Start, then let's the game begin.
        if User_Row >= 296 && User_Row <= 459 && User_Column <= 612 && User_Column >= 562
            ready = 1;
            [y5, f5] =audioread('LS.mp3');
            sound(y5, f5);
            pause(1)
            clear sound;
            break;
        end
    end
    
    close all;
    
    [y5, f5] =audioread('SCO.mp3');
    sound(y5, f5);
  
    %Creating a 10 x 10 matrix with nested for loops
    playerArray = zeros(10,10);
    computerArray = zeros(10,10);

    load Battleship % Loads the player (Player_Board) and computer
    %(Opponent_Board) boards (10×10 cell arrays) along with a number of different image, shown below.
    % figure('Renderer', 'painters', 'Position', [400 300 1106 623])
    % simpleGameEngine(Image Name,Height, Width, Zoom Factor);
    OpenWater = simpleGameEngine('BS.png',16,16,10);
    UserOWBoard = ones(10,10)*16;
    EnemyOWBoard = ones(10,10)*16;
    NoMenLine = ones(1,10);
    CleanBoard = [EnemyOWBoard;NoMenLine;UserOWBoard];
    drawScene(OpenWater,CleanBoard); 
    title('Selecting War Machines...')


    % start = simpleGameEngine('Start.PNG',50,700,5);
    % % drawScene(simpleGameEngine, SpriteID)
    % drawScene(startPage,1); 
    % hold on
    % drawScene(start,1);
    
    % AI's Battleships' Placement by using for loop
    for numBattleships = 1:5
        
        % AI Battleship Selections.
        Battleships = randi([1, 5], 1);
        % Horizontal, 0 or Vertical, 1
        AIchoice = randi([0, 1], 1);

        % If Vertical
        if AIchoice == 1

            while checkComplete == 0
                % AI's aircraft carrier.
                AI_AC_x = randi([1, 4+Battleships], 1);
                AI_AC_y = randi([1, 10], 1);

                % Check for violation.
                for counter = 1 : 7-Battleships
                    if computerArray(AI_AC_x+counter-1,AI_AC_y)==1
                        violate = 1;
%                         fprintf('error\n')
                        break;
                    end
                end

                if violate ~= 1
                    checkComplete = 1;
                end
                violate = 0;

            end
            violate = 0; checkComplete = 0;

            computerArray(AI_AC_x:AI_AC_x+6-Battleships,AI_AC_y) = 1;

%             EnemyOWBoard(AI_AC_x, AI_AC_y) = 8;
%             if Battleships ~= 5
%                 for numBody = 1:5-Battleships
%                     EnemyOWBoard(AI_AC_x+numBody, AI_AC_y) = 12;
%                 end
%             end
%             EnemyOWBoard(AI_AC_x+6-Battleships, AI_AC_y) = 2;

%             drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard] );

        % If Horizontal
        elseif AIchoice == 0
            
            while checkComplete == 0
                % AI's aircraft carrier.
                AI_AC_x = randi([1, 10], 1);
                AI_AC_y = randi([1, 4+Battleships], 1);

                % Check for violation.
                for counter = 1 : 7-Battleships
                    if computerArray(AI_AC_x,AI_AC_y+counter-1)==1
                        violate = 1;
%                         fprintf('error\n')
                        break;
                    end
                end

                if violate ~= 1
                    checkComplete = 1;
                end
                violate = 0;

            end 
            violate = 0; checkComplete = 0;

            computerArray(AI_AC_x ,AI_AC_y:AI_AC_y+6-Battleships) = 1;

%             EnemyOWBoard(AI_AC_x, AI_AC_y) = 4;
%             if Battleships ~= 5
%                 for numBody = 1:5-Battleships
%                     EnemyOWBoard(AI_AC_x, AI_AC_y+numBody) = 10;
%                 end
%             end
%             EnemyOWBoard(AI_AC_x, AI_AC_y+6-Battleships) = 6;
%             drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard]) ;

        end
    end
    
    %% Player's Battleships' Placement by using for loop
    for numBattleships = 1:5
        
        WarMachineList = {'Aircraft Carrier - 6 Boxes',...
                          'JFK Destroyer - 5 Boxes',...
                          'Plasma Battleship - 4 Boxes',...
                          'Nuclear-powered Submarine - 3 Boxes',...  
                          'Drone Boat - 2 Boxes'};
                      
        [indx,tf] = listdlg('ListString',WarMachineList);
        
        if length(indx) > 1
            clear indx
            indx = 0;
        end
        
        switch indx
            
            % Aircraft Carrier
            case 1
                UserBattleships = 1;
            % JFK Destroyer
            case 2
                UserBattleships = 2;
            % Plasma Battleship
            case 3
                UserBattleships = 3;
            % Nuclear-powered Submarine
            case 4
                UserBattleships = 4;
            % Drone Boat
            case 5
                UserBattleships = 5;
                
            otherwise
                UserBattleships = randi([1 5],1);
        end
        % Horizontal, 0 or Vertical, 1
        Position = questdlg('Horizontal or Vertical Orientation?', ...
                            'Orientation Selection', ...
                            'Horizontal',...
                            'Vertical',...
                            'Horizontal');
                        
        % Handle response
        switch Position
            
            case 'Horizontal'
                orientation = 0;
            case 'Vertical'
                orientation = 1;
        end


        % If Vertical
        if orientation == 1

            while checkComplete == 0
                
                % User's Location Selection
                [U_AC_x, U_AC_y] = getMouseInput(OpenWater);
                
                if ((U_AC_x-11) > 4+UserBattleships)
                    violate = 1;
                    OKbutton = questdlg('Your War Machine is Out of the Board Game! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f2 = msgbox({'Your War Machine is Out of the Board Game!';'Please Choose Another Location.'});
%                     pause(3);
%                     delete(f2)
                    continue;
                end
                
                if (U_AC_x <= 10 && U_AC_x >= 1) && (U_AC_y <= 10 && U_AC_y >= 1)
                    violate = 1;
                    OKbutton = questdlg('You are selecting the enemy area! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f2 = msgbox({'You are selecting the enemy area!';'Please Choose Another Location.'});
%                     pause(3);
%                     delete(f2)
                    continue;
                end
                
                if (U_AC_x == 11) && (U_AC_y <= 10 && U_AC_y >= 1)
                    violate = 1;
                    OKbutton = questdlg('You are selecting the no men area! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f3 = msgbox({'You are selecting the no men area!';'Please Choose Another Location.'});
%                     pause(3);
%                     delete(f3)
                    continue
                end

                % Check for violation.
                for counter = 1 : 7-UserBattleships
                    if playerArray((U_AC_x-11)+counter-1,U_AC_y)==1
                        violate = 1;
                        OKbutton = questdlg('War Machine Are Colliding! Please Choose Another Location.', ...
                                        'Warning!', ...
                                        'OK',...
                                        'OK');

                        % Handle response
                        switch OKbutton

                            case 'OK'

                        end
%                         f1 = msgbox({'War Machine Are Colliding!';'Please Choose Another Location.'});
%                         pause(3);
%                         delete(f1)
                        break;
                    end
                end

                if violate ~= 1
                    checkComplete = 1;
                end
                violate = 0;

            end
            violate = 0; checkComplete = 0;

            playerArray((U_AC_x-11):(U_AC_x-11)+6-UserBattleships,U_AC_y) = 1;

            UserOWBoard((U_AC_x-11), U_AC_y) = 8;
            if UserBattleships ~= 5
                for numBody = 1:5-UserBattleships
                    UserOWBoard((U_AC_x-11)+numBody, U_AC_y) = 12;
                end
            end
            UserOWBoard((U_AC_x-11)+6-UserBattleships, U_AC_y) = 2;

            drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard] );

        % If Horizontal
        elseif orientation == 0
            
            while checkComplete == 0

                % User's Location Selection
                [U_AC_x, U_AC_y] = getMouseInput(OpenWater);
                
                if (U_AC_y > 4+UserBattleships)
                    violate = 1;
                    OKbutton = questdlg('Your War Machine is Out of the Board Game! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f2 = msgbox({'Your War Machine is Out of the Board Game!';'Please Choose Another Location.'});
%                     pause(3);
%                     delete(f2)
                    continue;
                end
                
                if (U_AC_x == 11) && (U_AC_y <= 10 && U_AC_y >= 1)
                    violate = 1;
                    OKbutton = questdlg('You are selecting the no men area! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f3 = msgbox({'You are selecting the no men area!';'Please Choose Another Location.'}); 
%                     pause(3);
%                     delete(f3)
                    continue;
                end
                
                if (U_AC_x <= 10 && U_AC_x >= 1) && (U_AC_y <= 10 && U_AC_y >= 1)
                    violate = 1;
                    OKbutton = questdlg('You are selecting the enemy area! Please Choose Another Location.', ...
                                    'Warning!', ...
                                    'OK',...
                                    'OK');
  
                    % Handle response
                    switch OKbutton

                        case 'OK'
                            
                    end
%                     f2 = msgbox({'You are selecting the enemy area!';'Please Choose Another Location.'});
%                     pause(3);
%                     delete(f2)
                    continue;
                end
                

                % Check for violation.
                for counter = 1 : 7-UserBattleships
                    if playerArray((U_AC_x-11),U_AC_y+counter-1)==1
                        violate = 1;
                        OKbutton = questdlg('War Machine Are Colliding! Please Choose Another Location.', ...
                                        'Warning!', ...
                                        'OK',...
                                        'OK');

                        % Handle response
                        switch OKbutton

                            case 'OK'

                        end
%                         f = msgbox({'War Machine Are Colliding!';'Please Choose Another Location.'});
%                         pause(3);
%                         delete(f)
                        break;
                    end
                end

                if violate ~= 1
                    checkComplete = 1;
                end
                violate = 0;

            end 
            violate = 0; checkComplete = 0;

            playerArray((U_AC_x-11) ,U_AC_y:U_AC_y+6-UserBattleships) = 1;

            UserOWBoard((U_AC_x-11), U_AC_y) = 4;
            if UserBattleships ~= 5
                for numBody = 1:5-UserBattleships
                    UserOWBoard((U_AC_x-11), U_AC_y+numBody) = 10;
                end
            end
            UserOWBoard((U_AC_x-11), U_AC_y+6-UserBattleships) = 6;
            [y22, f22] =audioread('PLACE.mp3');
            sound(y22, f22);
            drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard]) ;

        end
 
    end
    
    clear sound


    %% Targetting System
    title('Sea Wars Have Begun!')
    [y6, f6] =audioread('EPIC.mp3');
    sound(y6, f6);

    % Set up boolFlag
    playerBattleshipRemaining = 1;
    AIBattleshipRemaining = 1;

    % Run until no ships remain
    while playerBattleshipRemaining == 1 && AIBattleshipRemaining == 1

        % Take and check row input
        [row, column] = getMouseInput(OpenWater);
        
        while row > 10
            [row, column] = getMouseInput(OpenWater);
            OKbutton = questdlg('Invalid Selection!', ...
                'Error', ...
                'OK',...
                'OK');

            % Handle response
            switch OKbutton

                case 'OK'

            end
%             errr=msgbox('Invalid Selection', 'Error','error');
%             pause(3);
%             delete(errr)
        end

        % Test if coordinate is new
        while ~(computerArray(row,column) == 0 || computerArray(row,column) == 1)
            OKbutton = questdlg('This coordinate has already been tried.', ...
                'Status', ...
                'OK',...
                'OK');

            % Handle response
            switch OKbutton

                case 'OK'

            end
%             same = msgbox('This coordinate has already been tried.','Status');
%             pause(3);
%             delete(same)
            [row, column] = getMouseInput(OpenWater);
        end

        % Modify board
        computerArray(row,column) = computerArray(row,column) + 2;
        % 0 = Water, 1 = Ship (No Hit), 2 = Miss, 3 = Hit

        % Display miss or hit
        if computerArray(row,column) == 2
            EnemyOWBoard(row, column) = 15;
%             miss=msgbox('Missed Target.','Results');
            [y12, f12] =audioread('WATER.mp3');
            sound(y12, f12);
            OKbutton = questdlg('Missed Target', ...
                'Result', ...
                'OK',...
                'OK');

            % Handle response
            switch OKbutton

                case 'OK'

            end
%             pause(3);
%             delete(miss)
        else
            EnemyOWBoard(row, column) = 14;
%             hit=msgbox('Target Hit! Nice Work!','Results');
            [y20, f20] =audioread('EXPLO.mp3');
            sound(y20, f20);
            OKbutton = questdlg('Target Hit! Nice Work!', ...
                'Result', ...
                'OK',...
                'OK');

            % Handle response
            switch OKbutton

                case 'OK'

            end
%             pause(3);
%             delete(hit)
        end

        drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard])

        % Test for remaining computer ships
        AIBattleshipRemaining = 0;
        for i = 1:10
            for j = 1:10
                if computerArray(i,j) == 1
                    AIBattleshipRemaining = 1;
                end
            end
            clear j
        end
        clear i

        % Run if CPU still has ships
        if AIBattleshipRemaining == 1
            % Choose x and y coordinates
            row = randi(10);
            column = randi(10);

            % Test if coordinate is new
            while ~(playerArray(row,column) == 0 || playerArray(row,column) == 1)

                % Choose new x and y coordinates
                row = randi(10);
                column = randi(10);

            end

            % Modify board
            playerArray(row,column) = playerArray(row,column) + 2;

            % Display miss or hit
            if playerArray(row,column) == 2
                UserOWBoard(row, column) = 15;
            else
                if UserOWBoard(row, column) == 2
                    UserOWBoard(row, column) = 3;
                elseif UserOWBoard(row, column) == 4
                    UserOWBoard(row, column) = 5;
                elseif UserOWBoard(row, column) == 6
                    UserOWBoard(row, column) = 7;
                elseif UserOWBoard(row, column) == 8
                    UserOWBoard(row, column) = 9;
                elseif UserOWBoard(row, column) == 10
                    UserOWBoard(row, column) = 11;
                elseif UserOWBoard(row, column) == 12
                    UserOWBoard(row, column) = 13;
                end
%                 nooo=msgbox('Oh no! You are hit!','Results');
                [y20, f20] =audioread('EXPLO.mp3');
                sound(y20, f20);
                OKbutton = questdlg('Oh no! You are hit!', ...
                        'Result', ...
                        'OK',...
                        'OK');

                % Handle response
                switch OKbutton

                    case 'OK'

                end
%                 pause(3);
%                 delete(nooo)
                
            end
            
            drawScene(OpenWater,[EnemyOWBoard;NoMenLine;UserOWBoard])

            % Test for remaining player ships
            playerBattleshipRemaining = 0;
            for i = 1:10
                for j = 1:10
                    if playerArray(i,j) == 1
                        playerBattleshipRemaining = 1;
                    end
                end
                clear j
            end
            clear i
        end
       
    end
    
    clear sound

    %% Game Over
    % Output proper message
    if AIBattleshipRemaining == 0
        [y54, f54] =audioread('WIN.mp3');
        sound(y54, f54);
        congratz = imread('CONGRATZ2.png');
        imshow(congratz);
        title('You Won!')
        while true
            % Mouse Input from User
            [User_Row, User_Column] = ginput(1);

            % If Start, then let's the game begin.
            if User_Row >= 677 && User_Row <= 855 && User_Column <= 825 && User_Column >= 753
                ready = 1;
                [y5, f5] =audioread('LS.mp3');
                sound(y5, f5);
                pause(1)
                clear sound;
                break;
            end
        end
    else
        [y6, f6] =audioread('DEF.mp3');
        sound(y6, f6);
        defeated = imread('DEF.png');
        imshow(defeated);
        title('You Have Lost. Better Luck Next Time.')
        while true
            % Mouse Input from User
            [User_Row, User_Column] = ginput(1);

            % If Start, then let's the game begin.
            if User_Row >= 591 && User_Row <= 797 && User_Column <= 763 && User_Column >= 697
                ready = 1;
                [y5, f5] =audioread('LS.mp3');
                sound(y5, f5);
                pause(1)
                clear sound;
                break;
            end
        end
    end
    close all;
    delete all;
end




