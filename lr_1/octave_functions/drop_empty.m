function after = drop_empty(before)
    after = before(~isnan(before));
    after = after(~after == 0);

