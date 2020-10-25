function mean_error = naive(data)
    % size(data, 2) -> n_columns
    % we should subtract 1 from the length due to mase loss(it adds +1 for the predictions)
    errors = nan([1 size(data, 2) - 1]); % ошибки прогноза
    % for each column
    for i = 1:size(data, 2) - 1
        if i<=366
            window_ = 12; % период ряда
            %t = 24; % прогноз на 24 точки
        else
            window_ = 4; % период ряда
            %t = 8; % на 8
        end;
        % one location data for the whole years, abt 310 entries
        location_data = data(:, i);
        % данные за последний известный нам год
        last_year_data = location_data(end + 1 - 3 * window_: end - 2 * window_);
        % дублируем его
        last_year_data = [last_year_data; last_year_data];
        errors(i) = mase(location_data, last_year_data, window_);
    end;
    % get mean error for all locations
    mean_error = mean(errors);
