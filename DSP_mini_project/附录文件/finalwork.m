clear; clc; close all;

fs = 44100;          
scale = 'F';         
bpm = 80;            
one_beat = 60/bpm;  

% --- 音色设置：单簧管风格 (Clarinet) ---
timbre_weights = [1.0, 0.05, 0.5, 0.0, 0.3, 0.0, 0.1];

T_intro = [5 6 1 6 5 3, 6 1 2 3 2 1 6 5, 1 2 3 2 1 2];
O_intro = [-1 -1 0 -1 -1 -1, -1 0 0 0 0 0 -1 -1, 0 0 0 0 0 0];
R_intro = zeros(size(T_intro));
B_intro = [0.5 0.5 0.5 0.5 1 1, 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5, 1.5 0.5 0.5 0.5 0.5 2];

% --- 主歌 A段 ---
T_v1 = [1 1 2, 3 3 2 1 1 6 5, 1 2 3 2 1 2];
O_v1 = [0 0 0, 0 0 0 0 0 -1 -1, 0 0 0 0 0 0];
R_v1 = zeros(size(T_v1));
B_v1 = [1 0.5 0.5, 1 0.5 0.5 0.5 0.5 0.5 0.5, 1.5 0.5 0.5 0.5 0.5 2];

T_v2 = [1 1 2 3 3 2 2 2 1, 6 6 2 1 1 6, 5];
O_v2 = [0 0 0 0 0 0 0 0 0, -1 -1 0 0 0 -1, -1];
R_v2 = zeros(size(T_v2));
B_v2 = [1 0.5 0.5 1 0.5 0.5 0.5 0.5 0.5, 1.5 0.5 1.5 0.5 0.5 0.5, 3];

% --- 主歌 B段 ---
T_v3 = [5 5 6 1 1, 2 3 2 1 6, 2 3 2 1 1 2 6 5 6];
O_v3 = [-1 -1 -1 0 0, 0 0 0 0 -1, 0 0 0 0 0 0 -1 -1 -1];
R_v3 = zeros(size(T_v3));
B_v3 = [0.5 0.5 0.5 1 1, 0.5 0.5 0.5 0.5 2, 1.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1];

T_v4 = [5 6 1 2 3, 5 3 2 1 2 1 6, 6 2 7 6 5, 5];
O_v4 = [-1 -1 0 0 0, 0 0 0 0 0 0 -1, -1 0 -1 -1 -1, -1];
R_v4 = zeros(size(T_v4));
B_v4 = [1.5 0.5 1 1 1, 1 0.5 0.5 0.5 0.5 0.5 0.5, 1 1 1 0.5 0.5, 3];

% --- 副歌 ---
T_ch1 = [5 5 5 5 5 3 5 6, 6 5 3, 6 6 5 6 6 5 5 3, 2];
O_ch1 = [0 0 0 0 0 0 0 0, 0 0 0, 0 0 0 0 0 0 0 0, 0];
R_ch1 = zeros(size(T_ch1));
B_ch1 = [0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5, 1.5 0.5 2, 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5, 3];

T_ch2 = [6 5 6 2, 2 3 2 1 6, 2 2 2 2 1 6, 5];
O_ch2 = [-1 -1 -1 0, 0 0 0 0 -1, 0 0 0 0 0 -1, -1];
R_ch2 = zeros(size(T_ch2));
B_ch2 = [1 0.5 0.5 2, 0.5 0.5 0.5 0.5 2, 1.5 0.5 0.5 0.5 0.5 0.5, 3];

% --- 结尾 ---
T_end = [5 5 6 3, 2 3 2 1 6, 3 2 2 2 1 6, 5 0];
O_end = [-1 -1 -1 0, 0 0 0 0 -1, 0 0 0 0 0 -1, -1 0];
R_end = zeros(size(T_end));
B_end = [1 0.5 0.5 2, 0.5 0.5 0.5 0.5 2, 1.5 0.5 0.5 0.5 1 1, 3 1];

Tones    = [T_intro T_v1 T_v2 T_v3 T_v4 T_ch1 T_ch2 T_end];
Octaves  = [O_intro O_v1 O_v2 O_v3 O_v4 O_ch1 O_ch2 O_end];
Risings  = [R_intro R_v1 R_v2 R_v3 R_v4 R_ch1 R_ch2 R_end];
Beats    = [B_intro B_v1 B_v2 B_v3 B_v4 B_ch1 B_ch2 B_end];

fprintf('正在生成音频...\n');
fprintf('调用函数: gen_music.m\n');
music_wave = gen_music(Tones, scale, Octaves, Risings, Beats, one_beat, fs, timbre_weights);

filename = 'Mom_Kiss.wav';
audiowrite(filename, music_wave, fs);
fprintf('生成成功！文件已保存为: %s\n', filename);
figure('Color', 'w', 'Name', 'Analysis');

subplot(2,1,1);
plot(music_wave(1:min(length(music_wave), 22050))); 
title('时域波形 (单簧管风格 + 指数包络)');
xlabel('Sample'); ylabel('Amplitude'); axis tight; grid on;

subplot(2,1,2);
L = 4096;
if length(music_wave) > L
    snippet = music_wave(floor(length(music_wave)/2) : floor(length(music_wave)/2)+L-1);
    Y = fft(snippet);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    f_axis = fs*(0:(L/2))/L;
    
    plot(f_axis, P1, 'LineWidth', 1.5);
    xlim([0 3000]); 
    title('频域分析 (谐波分布情况)');
    xlabel('Frequency (Hz)'); ylabel('Magnitude'); grid on;
end