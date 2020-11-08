function mean_error = linear_pred(data)
    % Запуск линейного метода
    errors = nan([1 size(data, 2) - 1]); % ошибки прогноза
    % for each columnt in data
    reg_term = 0.3;
    for i = 1:size(data, 2) - 1
        if i<=366
            window_ = 12; % период ряда
        else
            window_ = 4; % период ряда
        end;
        % one location data for the whole years, abt 310 entries
        one_location_data = data(:, i);
        one_location_data = drop_empty(one_location_data);
        % predict for X points(actually, one year)
        all_but_last_two_years = one_location_data(1:end - 2 * window_);
        % predict for the same size as was removed from original data
        pred = forec(all_but_last_two_years, window_, 2 * window_, reg_term);
        errors(i) = mase(one_location_data, pred, window_);
    end;
    mean_error = [mean(errors(1:366)) mean(errors(366:end)) mean(errors)];
