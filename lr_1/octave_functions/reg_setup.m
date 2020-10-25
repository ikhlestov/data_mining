function reg_setup(data)
    regs = 0.1:0.02:0.6;
    errors = nan([length(regs) size(data,2) - 1]); % ошибки прогноза
    for j=1:length(regs)
        for i = 1:size(data,2) - 1
            if i<=366
                window_ = 12;
            else
                window_ = 4;
            end;
            one_location_data = data(:,i);
            one_location_data = drop_empty(one_location_data);
            % f(isnan(f)) = [];
            [pred model_h] = forec(one_location_data(1:end - 2*window_), window_, 2*window_, regs(j));
            % errors(j, i) = mase(one_location_data, pred, window_);

            % modified error to check model overfiting
            errors(j, i) = mean(abs(model_h - one_location_data(1: end - 2 * window_))) ./ mean(one_location_data(1: end - 2 * window_));
        end;
        j % для вывода "счётчика"
    end;
    % визуализация
    figure(2);
    clf;
    plot(regs, mean(errors'), 'LineWidth', 1.5);
    hold on;
    plot(regs, mean(errors(:,1:366)'), 'k');
    plot(regs, mean(errors(:,366:end)'), 'r');
    xlabel('Reg term')
    ylabel('Error')
    legend('All entries', 'Month based', 'Quarter based');
