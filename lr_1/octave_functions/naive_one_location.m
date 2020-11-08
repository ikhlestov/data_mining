function error_ = naive_one_location(location_data)
    window_ = 12; % период ряда
    %t = 24; % прогноз на 24 точки
    % данные за два года назад
    %% original
    % last_year_data = location_data(end + 1 - 3 * window_: end - 2 * window_);  % size == window_
    % дублируем его
    % last_year_data = [last_year_data; last_year_data];  % size == window_ * 2
    % error_ = mase(location_data, last_year_data, window_);

    %% my approach
    % дагнные год назад
    % last_year_data = location_data(end + 1 - 2 * window_: end - 1 * window_);  % size == window_
    test_data = location_data(end - 2 * window_ + 1: end);
    disp(test_data);
    disp(size(test_data));
    train_data = location_data(1:end - 2 * window_);
    predicted = train_data(end - 2 * window_ + 1: end);
    error_ = mase(test_data, predicted, window_);
    plot(predicted);
    hold on;
    plot(test_data);
    legend("Prediction", "GT");
