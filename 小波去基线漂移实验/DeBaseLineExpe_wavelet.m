function myfilter();
clear all;
readfile = 'F:\project\experimentdata\basedrift\data7.dat'; 
 fid = fopen(readfile,'r');     %把filename文件名的内容读出，放f中。
 [f,count] = fread(fid,'short');
 fclose(fid);                    %关闭该文件;
 datalength = 2048;
 xlength = 3000;
 s = f(1:datalength);
maxlev=7;                       %分解6尺度
[C,L] = wavedec(s,maxlev,'coif3');

figure(1);
%绘出分解后重构的的逼近信息和细节细节
AA1=wrcoef('a',C,L,'coif3',1);
AA2=wrcoef('a',C,L,'coif3',2);
AA3=wrcoef('a',C,L,'coif3',3);
AA4=wrcoef('a',C,L,'coif3',4);
AA5=wrcoef('a',C,L,'coif3',5);
AA6=wrcoef('a',C,L,'coif3',6);
AA7=wrcoef('a',C,L,'coif3',7);

 DD1=wrcoef('d',C,L,'coif3',1);
 DD2=wrcoef('d',C,L,'coif3',2);
 DD3=wrcoef('d',C,L,'coif3',3);
 DD4=wrcoef('d',C,L,'coif3',4);
 DD5=wrcoef('d',C,L,'coif3',5);
 DD6=wrcoef('d',C,L,'coif3',6);
 DD7=wrcoef('d',C,L,'coif3',7);


%提取分解后逼近系数和细节系数
A1=appcoef(C,L,'coif3',1);
A2=appcoef(C,L,'coif3',2);
A3=appcoef(C,L,'coif3',3);
A4=appcoef(C,L,'coif3',4);
A5=appcoef(C,L,'coif3',5);
A6=appcoef(C,L,'coif3',6);
A7=appcoef(C,L,'coif3',7);


D1=detcoef(C,L,1);
D2=detcoef(C,L,2);
D3=detcoef(C,L,3);
D4=detcoef(C,L,4);
D5=detcoef(C,L,5);
D6=detcoef(C,L,6);
D7=detcoef(C,L,7);
 
subplot(8,2,1);
plot(s);
title('original');
axis([0,datalength,-500,500]);
subplot(8,2,3);
plot(AA1);
ylabel('A1');
axis([0,datalength,-500,500]);
subplot(8,2,5);
plot(AA2);
ylabel('A2');
axis([0,datalength,-500,500]);
subplot(8,2,7);
plot(AA3);
ylabel('A3');
axis([0,datalength,-500,500]);
subplot(8,2,9);
plot(AA4);
ylabel('A4');
axis([0,datalength,-500,500]);
subplot(8,2,11);
plot(AA5);
ylabel('A5');
axis([0,datalength,-500,500]);
subplot(8,2,13);
plot(AA6);
ylabel('A6');
axis([0,datalength,-500,500]);
subplot(8,2,15);
plot(AA7);
ylabel('A7');
axis([0,datalength,-500,500]);

 subplot(8,2,4);
 plot(DD1);
ylabel('D1');
 axis([0,datalength,-20,20]);
 subplot(8,2,6);
 plot(DD2);
ylabel('D2');
axis([0,datalength,-50,50]);
 subplot(8,2,8);
 plot(DD3);
ylabel('D3');
axis([0,datalength,-200,200]);
 subplot(8,2,10);
 plot(DD4);
ylabel('D4');
axis([0,datalength,-200,200]);
 subplot(8,2,12);
 plot(DD5);
ylabel('D5');
axis([0,datalength,-200,200]);
 subplot(8,2,14);
 plot(DD6);
ylabel('D6');
axis([0,datalength,-200,200]);
 subplot(8,2,16);
 plot(DD7);
ylabel('D7');
axis([0,datalength,-200,200]);
 figure(2);
 %将第一尺度置零
%  D1= zeros(1,length(D1));
%  D2= zeros(1,length(D2));
 A7=zeros(1,length(A7));
 C2 = [A7,D7',D6',D5',D4',D3',D2',D1'];  %
 s2 = waverec(C2,L,'coif3');
 subplot(312);
 plot(s2,'k');
%  title('the denosed signal');
 axis([0,datalength,-400,500]);
 subplot(311);
 plot(s,'k');
%  title('the original signal');
 axis([0,datalength,-400,500]);
 
%噪声信号
for i = 1:datalength
    noisesig(i) = s(i) - s2(i);
end
subplot(313);
t = 1:datalength;
plot(t,noisesig,'k');
axis([0,datalength,-400,500]);
% title('baseline drift');
% plot(noisesig);

