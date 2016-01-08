clear all
%打开电容传感器测试数据文件
% CalculateDataRead=xlsread('F:\访问学者\灵巧手\数据分析\前两组数据.xls','sheet2')
% CalculateDataRow=size(CalculateDataRead,1);   %存放采样文件中采用次数
% CalculateData=CalculateDataRead(:,2:3);   
% X1=CalculateDataRead(:,1)
% Y1=CalculateDataRead(:,2)
% Y2=CalculateDataRead(:,3)
% plot(X1,Y1,'r');
% hold on
% plot(X1,Y2,'b');

%打开电阻传感器测试数据文件
CalculateDataRead=xlsread('F:\访问学者\灵巧手\数据分析\柔性传感器 (1).xlsx','第三组')
%24点阵传感器数据整理
SENSORROW=4;                        %传感器阵列的行数
SENSORCOL=6;                        %传感器阵列的列数
SampleNum=16;                         %采集的数据量
SENSORNUM=SENSORROW*SENSORCOL;          

SampleData1=CalculateDataRead(19:(SampleNum+18),2:(SENSORNUM+1));  %第一组
SampleData2=CalculateDataRead(40:(SampleNum+39),2:(SENSORNUM+1));  %第二组
X1=CalculateDataRead(19:(SampleNum+18),1);

%CalculateDataRow=size(CalculateDataRead,1);   %存放采样文件中采用次数
%for n=1:SENSORNUM
n=1;
Y1=SampleData1(:,n)
Y2=SampleData2(:,n)
N=SampleNum
X=[X1(1:N)',X1(1:N)'];
Y=[Y1(1:N)',Y2(1:N)'];
A=polyfit(X(1:2*N),Y(1:2*N),1);
fity1=polyval(A,X(1:N));
scatter(X(1:2*N),Y(1:2*N),'r')
hold on;
plot(X(1:N),fity1);
%对于小于0.1N的数据进行回归分析
Xm=[ones(size(X))',X'];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) ; %一元线性回归分析
%rcoplot(r1,rint1)  %残差分析，是否存在异常点；


%对于小于0.1N的数据进行非线性拟合
A=polyfit(X,Y,3);
fity1=polyval(A,X(1:N));
scatter(X,Y,'r')
hold on;
plot(X(1:N),fity1);
Xm=[ones(size(X))',X',X'.^2,X'.^3];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) 

Xm=[ones(size(X))',log(X')];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) 

%对于0.1N—40N的数据进行线性拟合
ULIMIT=7    %后面测试的6组数由于超限，所以剔除
DLIMIT=2   %前面测试的10组数由于不符合变化规律，所以剔除
COL=size(X1,1);
X=[X1(DLIMIT:COL-ULIMIT)',X1(DLIMIT:COL-ULIMIT)']';
Y=[Y1(DLIMIT:COL-ULIMIT)',Y2(DLIMIT:COL-ULIMIT)']';
%X=[ones(size(X),1),X,X.^2,X1.^3,];
A=polyfit(X,Y,1);
scatter(X,Y,'r')
hold on;
fity1=polyval(A,X(1:(size(X,1)*0.5)));
plot(X(1:(size(X,1)*0.5)),fity1);
%对于0.1N—40N的数据进行回归分析
Xm=[ones(size(X,1),1),X];
[b1,bint1,r1,rint1,s1]=regress(Y,Xm) ; %一元线性回归分析
rcoplot(r1,rint1)  %残差分析，是否存在异常点；

%对于0.1N—40N的数据进行非线性拟合
X=[X1(DLIMIT:CalculateDataRow-ULIMIT)',X1(DLIMIT:CalculateDataRow-ULIMIT)']';
Y=[Y1(DLIMIT:CalculateDataRow-ULIMIT)',Y2(DLIMIT:CalculateDataRow-ULIMIT)']';
%X=[ones(size(X),1),X,X.^2,X1.^3,];
A=polyfit(X,Y,3);
scatter(X,Y,'r')
hold on;
fity1=polyval(A,X(1:(size(X,1)*0.5)));
plot(X(1:(size(X,1)*0.5)),fity1);
%对于0.1N—40N的数据进行回归分析
Xm=[ones(size(X,1),1),X,X.^2,X.^3];
[b1,bint1,r1,rint1,s1]=regress(Y,Xm) ; %一元线性回归分析
rcoplot(r1,rint1)  %残差分析，是否存在异常点；
