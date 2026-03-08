function full_music = gen_music(tones, scale, noctaves, risings, beats, one_beat, fs, weights)
    full_music = [];
    
    for i = 1:length(tones)
        duration = beats(i) * one_beat;
        wav = gen_wave(tones(i), scale, noctaves(i), risings(i), duration, fs, weights);
        full_music = [full_music, wav];
    end
    
    % 归一化
    full_music = full_music / max(abs(full_music)) * 0.9;
end