function [optimal_time_window] = get_dissimilarity_plot(L,timespan,day,comments)

plot(timespan/60,L(:,day));
hold on

[Lmax Lmax_index] = max(L(:,day));

optimal_time_window = timespan(Lmax_index)/60;

vline(optimal_time_window,'-r',num2str(optimal_time_window));

xlabel('time window (minutes)'),ylabel('-log likelihood')

if exist('comments','var')
   title(strcat(comments,'-day:',num2str(day)));
end

hold off
end