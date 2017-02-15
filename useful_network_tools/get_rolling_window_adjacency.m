function A = get_rolling_window_adjacency(filename, nodes, window, stepSize, nsteps, start)

% read and parse csv file
fid = fopen(filename,'rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

% Convert datetime to serial datetime
C{1,3} = datenum(C{1,3});


%Setting bounds
if (nargin < 6)
    start = C{1,3}(1,1);
end;
tlower = start;
tupper = start + window;




for l = 1:nsteps
    
    s = num2str(l);
    step = strcat('s',s);
    
    % Generate Adjacency Matrix
    A.(step) = get_directed_adjacency(C,nodes, tlower, tupper);

    tlower = tlower + stepSize;
    tupper = tupper + stepSize;
end

