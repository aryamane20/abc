clear
N=10^6
ip_bin=rand(1,N)>0.5;
ip_bpsk=2*ip_bin-1;
snr=[-3:10];
for i=1:length(snr)
  n=1/sqrt(2)*[randn(1,N) + j*randn(1,N)];
  y=ip_bpsk+ 10^(-snr(i)/20)*n;
  rec_op=real(y)>0;
  err(i)=size(find(ip_bin-rec_op),2);
end
simber=err/N;
theory= 0.5*erfc(sqrt(10.^(snr/10)));
%plot
figure 1
semilogy(snr,simber,"b-");
hold on
semilogy(snr,theory,"mx*");
grid on
axis([-3 10 10^-5 0.5]);


snr1=[-3:35];
for i=1:length(snr1)
  n=1/sqrt(2)*[randn(1,N) + j*randn(1,N)];
  h=1/sqrt(2)*[randn(1,N) + j*randn(1,N)];
  y1=h.*ip_bpsk+ 10^(-snr1(i)/20)*n;
  y_eq=y1./h;
  rec_op1=real(y_eq)>0;
  err1(i)=size(find(ip_bin-rec_op1),2);
end
simber1=err1/N;
eb_N0_lin=10.^(snr1/10);
theory1= 0.5.*(1-sqrt(eb_N0_lin./(eb_N0_lin+1)));
%plot
figure 2
semilogy(snr,theory,"g-");
hold on
semilogy(snr1,simber1,"b.-");
semilogy(snr1,theory1,"mx*");
grid on
axis([-3 35 10^-5 0.5]);
