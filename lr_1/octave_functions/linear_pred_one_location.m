function [two_years_prediction error_] = linear_pred_one_location(location_data)
    % Запуск линейного метода
    reg_term = 0.3;
    window_ = 12; % период ряда
    % one location data for the whole years, abt 310 entries
    location_data = drop_empty(location_data);
    test_data = location_data(end - 2 * window_ + 1: end);
    train_data = location_data(1:end - 2 * window_);

    % predict for X points(actually, one year)
    % all_but_last_two_years = location_data(1:end - 2 * window_);
    % predict for the same size as was removed from original data
    two_years_prediction = forec(train_data, window_, 2 * window_, reg_term);
    error_ = mase(test_data, two_years_prediction, window_);
    % plot(two_years_prediction);
    % hold on;
    % plot(test_data);
    % legend("Prediction", "GT");
