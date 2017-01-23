function diffs = get_observation_density(timestamps)

diffs = 0;

for i=2:length(timestamps)
    diffs(i) = diffs + timestamps(i) - timestamps(i-1);
end

diffs = diffs ./ (length(timestamps) - 1);
end