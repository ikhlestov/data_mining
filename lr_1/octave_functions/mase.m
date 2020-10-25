function error_ = mase(array, pred, window_)
    % просто вытянуть в вектор-столбец
    array = array(:);
    pred = pred(:);

    % на всякий случай удаляем пустые записи
    array(isnan(array)) = []; 
    array = array(~isnan(array));
    array = array(~array == 0);

    % difference between prediction and last values
    numerator = mean(
        abs(pred - array((end - length(pred) + 1):end))  % get slice
    );
    % difference etween array self copy
    denominator = mean(
        abs(array(1:(end - window_)) - array((window_ + 1):end))
    );
    error_ = numerator / denominator;
