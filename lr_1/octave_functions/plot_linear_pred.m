function plot_linear_pred(data)
    %Plot difference between linear predictions and real data
    i = 2;
    l = 12;
    f = data(:,i);
    % f(isnan(f)) = [];
    f = drop_empty(f);
    reg_term = 0.3;
    [z h] = forec (f(1:end-2*l), l, 2*l, reg_term);
    figure(1);
    clf;
    plot(f, 'LineWidth', 1.5);
    hold on;
    plot([h;z],'k')
    legend('Real data', 'Predicted');
    xlabel('Month/Year');
    ylabel('Value');
