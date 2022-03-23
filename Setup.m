function Ships = Setup( )
%Setup will determine the placement of the 5 ships that are part of the
%battleship game within the 10x10 gameboard.  The function will return a
%matrix where the 1st column of each row specifies the ship based on the
%list below, the second column specifies the direction (1 = vertical,      
%2 = horizontal), and the third and fourth columns specify the starting
%coordinate of the ship.
%
%   Example-row 1 of Ships is: [2 1 4 5] --> specifies that the battlehsip
%   is placed vertically starting at position row 4, col 5 and would thus
%   occupy the following coordinates: (4,5), (5,5), (6,5), (7,5).
%                     ID#     Length
%   Aircraft Carrier    1       5
%   Battleship          2       4
%   Submarine           3       3
%   Cruiser             4       3
%   PT Boat             5       2
%
%   Usage: Ships = Setup() returns the setup information for the game board

% set up variables
Ships = zeros(5,4);
lengths = [5 4 3 3 2];
locations = zeros(5,10);

% begin placing ships, starting with the largest
number_of_ships = 1;
while number_of_ships <= 5
    % pick a coordinate
    coord = randi([1,10],[1,2]);
    % check to see if it is already used for another ship
    used = 0;
    for k = 1:5
        for m = 1:2:9
            if (coord(1,1) == locations(k,m) && coord(1,2) == locations(k,m+1))
                used = 1;
            end
        end
    end
    if used
        continue;
    end
    % check to see if the boat will fit using that point at one end
    use_check = [1 1 1 1]; % [left right up down]
    for k = 1:5
        for m = 1:2:9
            % check left
            if coord(1) == locations(k,m) && coord(2) >= locations(k,m+1) && coord(2) - lengths(number_of_ships) <= locations(k,m+1) || coord(2) - lengths(number_of_ships) + 1 <= 0
                use_check(1) = 0;
            end
            % check right
            if coord(1) == locations(k,m) && coord(2) <= locations(k,m+1) && coord(2) + lengths(number_of_ships) >= locations(k,m+1) || coord(2) + lengths(number_of_ships) - 1 > 10
                use_check(2) = 0;
            end
            % check up
            if coord(1) >= locations(k,m) && coord(1) - lengths(number_of_ships) <= locations(k,m) && coord(2) == locations(k,m+1) || coord(1) - lengths(number_of_ships) + 1 <= 0
                use_check(3) = 0;
            end
            % check down
            if coord(1) + lengths(number_of_ships) >= locations(k,m) && coord(1) <= locations(k,m) && coord(2) == locations(k,m+1) || coord(1) + lengths(number_of_ships) - 1 > 10
                use_check(4) = 0;
            end
        end
    end
    % boat does not fit
    if (use_check(1) == 0 && use_check(2) == 0 && use_check(3) == 0 && use_check(4) == 0)
        continue;
    % boat fits in at least one orientation, so pick an orientation and
    % place the boat
    else
        pick = randi([1,4],1);
        while (use_check(pick) ~= 1)
            pick = randi([1,4],1);
        end
        switch pick
            case 1  %left
                for k = 1:lengths(number_of_ships)
                    locations(number_of_ships,2*k-1) = coord(1);
                    locations(number_of_ships,2*k) = coord(2) - lengths(number_of_ships) + k;
                end
                Ships(number_of_ships,1) = number_of_ships;
                Ships(number_of_ships,2) = 2;
                Ships(number_of_ships,3) = coord(1);
                Ships(number_of_ships,4) = coord(2) - lengths(number_of_ships) + 1;
            case 2  %right
                for k = 1:lengths(number_of_ships)
                    locations(number_of_ships,2*k-1) = coord(1);
                    locations(number_of_ships,2*k) = coord(2) + k - 1;
                end
                Ships(number_of_ships,1) = number_of_ships;
                Ships(number_of_ships,2) = 2;
                Ships(number_of_ships,3) = coord(1);
                Ships(number_of_ships,4) = coord(2);
            case 3  %up
                for k = 1:lengths(number_of_ships)
                    locations(number_of_ships,2*k-1) = coord(1) - lengths(number_of_ships) + k;
                    locations(number_of_ships,2*k) = coord(2);
                end
                Ships(number_of_ships,1) = number_of_ships;
                Ships(number_of_ships,2) = 1;
                Ships(number_of_ships,3) = coord(1) - lengths(number_of_ships) + 1;
                Ships(number_of_ships,4) = coord(2);
            case 4  %down
                for k = 1:lengths(number_of_ships)
                    locations(number_of_ships,2*k-1) = coord(1) + k - 1;
                    locations(number_of_ships,2*k) = coord(2);
                end
                Ships(number_of_ships,1) = number_of_ships;
                Ships(number_of_ships,2) = 1;
                Ships(number_of_ships,3) = coord(1);
                Ships(number_of_ships,4) = coord(2);
        end
        number_of_ships = number_of_ships + 1;
    end
end

