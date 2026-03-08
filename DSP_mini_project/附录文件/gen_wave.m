function waves = gen_wave(tone, scale, noctave, rising, duration, fs, weights)
    t = linspace(0, duration, round(duration * fs));
    
    if tone == 0
        waves = zeros(1, length(t));
        return;
    end
   
    f0 = tone2freq(tone, scale, noctave, rising);

    waves = zeros(1, length(t));
    for k = 1:length(weights)
        amp = weights(k);
        if amp > 0
            waves = waves + amp * sin(2 * pi * (k * f0) * t);
        end
    end
    decay = exp(-3 * t / duration); 
    
    % 边缘平滑 (防止 Click)
    fade_len = min(100, floor(length(t)/10));
    env = ones(1, length(t));
    env(1:fade_len) = linspace(0, 1, fade_len);
    env(end-fade_len+1:end) = linspace(1, 0, fade_len);
    waves = waves .* decay .* env;
end