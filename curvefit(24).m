clear all
%�򿪵��ݴ��������������ļ�
% CalculateDataRead=xlsread('F:\����ѧ��\������\���ݷ���\ǰ��������.xls','sheet2')
% CalculateDataRow=size(CalculateDataRead,1);   %��Ų����ļ��в��ô���
% CalculateData=CalculateDataRead(:,2:3);   
% X1=CalculateDataRead(:,1)
% Y1=CalculateDataRead(:,2)
% Y2=CalculateDataRead(:,3)
% plot(X1,Y1,'r');
% hold on
% plot(X1,Y2,'b');

%�򿪵��贫�������������ļ�
CalculateDataRead=xlsread('F:\����ѧ��\������\���ݷ���\���Դ����� (1).xlsx','������')
%24���󴫸�����������
SENSORROW=4;                        %���������е�����
SENSORCOL=6;                        %���������е�����
SampleNum=16;                         %�ɼ���������
SENSORNUM=SENSORROW*SENSORCOL;          

SampleData1=CalculateDataRead(19:(SampleNum+18),2:(SENSORNUM+1));  %��һ��
SampleData2=CalculateDataRead(40:(SampleNum+39),2:(SENSORNUM+1));  %�ڶ���
X1=CalculateDataRead(19:(SampleNum+18),1);

%CalculateDataRow=size(CalculateDataRead,1);   %��Ų����ļ��в��ô���
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
%����С��0.1N�����ݽ��лع����
Xm=[ones(size(X))',X'];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) ; %һԪ���Իع����
%rcoplot(r1,rint1)  %�в�������Ƿ�����쳣�㣻


%����С��0.1N�����ݽ��з��������
A=polyfit(X,Y,3);
fity1=polyval(A,X(1:N));
scatter(X,Y,'r')
hold on;
plot(X(1:N),fity1);
Xm=[ones(size(X))',X',X'.^2,X'.^3];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) 

Xm=[ones(size(X))',log(X')];
[b1,bint1,r1,rint1,s1]=regress(Y',Xm) 

%����0.1N��40N�����ݽ����������
ULIMIT=7    %������Ե�6�������ڳ��ޣ������޳�
DLIMIT=2   %ǰ����Ե�10�������ڲ����ϱ仯���ɣ������޳�
COL=size(X1,1);
X=[X1(DLIMIT:COL-ULIMIT)',X1(DLIMIT:COL-ULIMIT)']';
Y=[Y1(DLIMIT:COL-ULIMIT)',Y2(DLIMIT:COL-ULIMIT)']';
%X=[ones(size(X),1),X,X.^2,X1.^3,];
A=polyfit(X,Y,1);
scatter(X,Y,'r')
hold on;
fity1=polyval(A,X(1:(size(X,1)*0.5)));
plot(X(1:(size(X,1)*0.5)),fity1);
%����0.1N��40N�����ݽ��лع����
Xm=[ones(size(X,1),1),X];
[b1,bint1,r1,rint1,s1]=regress(Y,Xm) ; %һԪ���Իع����
rcoplot(r1,rint1)  %�в�������Ƿ�����쳣�㣻

%����0.1N��40N�����ݽ��з��������
X=[X1(DLIMIT:CalculateDataRow-ULIMIT)',X1(DLIMIT:CalculateDataRow-ULIMIT)']';
Y=[Y1(DLIMIT:CalculateDataRow-ULIMIT)',Y2(DLIMIT:CalculateDataRow-ULIMIT)']';
%X=[ones(size(X),1),X,X.^2,X1.^3,];
A=polyfit(X,Y,3);
scatter(X,Y,'r')
hold on;
fity1=polyval(A,X(1:(size(X,1)*0.5)));
plot(X(1:(size(X,1)*0.5)),fity1);
%����0.1N��40N�����ݽ��лع����
Xm=[ones(size(X,1),1),X,X.^2,X.^3];
[b1,bint1,r1,rint1,s1]=regress(Y,Xm) ; %һԪ���Իع����
rcoplot(r1,rint1)  %�в�������Ƿ�����쳣�㣻
