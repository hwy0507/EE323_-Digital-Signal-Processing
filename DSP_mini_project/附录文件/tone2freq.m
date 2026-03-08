function freq = tone2freq(tone, scale, noctave, rising)
    switch scale
        case 'C', base = 261.63;
        case 'D', base = 293.66;
        case 'E', base = 329.63;
        case 'F', base = 349.23; 
        case 'G', base = 392.00;
        case 'A', base = 440.00;
        case 'B', base = 493.88;
        otherwise, base = 261.63;
    end

    dic = [0, 2, 4, 5, 7, 9, 11];
    
    if tone >= 1 && tone <= 7
        n = dic(tone) + noctave * 12 + rising;
        freq = base * (2 ^ (n / 12));
    else
        freq = 0;
    end