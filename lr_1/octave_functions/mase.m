function error_ = mase(gt_, pred, window_)
    % просто вытянуть в вектор-столбец
    gt_ = gt_(:);
    pred = pred(:);

    % на всякий случай удаляем пустые записи
    gt_(isnan(gt_)) = []; 
    gt_ = gt_(~isnan(gt_));
    gt_ = gt_(~gt_ == 0);

    % difference between prediction and last values
    disp(length(pred));
    disp("GT size:");
    disp(length(gt_((end - length(pred) + 1):end)));
    numerator = mean(
        abs(pred - gt_((end - length(pred) + 1):end))  % get slice
    );
    % difference etween gt_ self copy
    % disp(size(gt_));
    % disp(size(gt_(1:(end - window_)) - gt_((window_ + 1):end)));
    % disp(gt_(1:(end - window_)));
    % disp(gt_((window_ + 1):end));
    % denominator = mean(
    %     % gt_[1:70] - gt_[70: 100]
    %     abs(gt_(1:(end - window_)) - gt_((window_ + 1):end))
    % );
    denominator = mean(
        abs(gt_((end - window_ + 1): (end - 1)) - gt_((end - window_ + 2): end))
    );
    disp(numerator);
    disp(denominator);
    error_ = numerator / denominator;
