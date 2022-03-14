t = -20:20;
u1 = 0.5 + 0.5*sign(t);
four = fft(u1);
mag = sqrt(real(four).^2 + imag(four).^2);
phase = atan(imag(four)/real(four));
subplot(2,2,1);
fplot(mag);
subplot(2,2,2);
fplot(phase);
fimplicit(mag);

