J_max=7
Iter=2
Iteri=10;
Resplot=zeros(10,2);
ErrorRec=Resplot;
Net={};
for i=1:Iteri
    [Resultsi,datai_PS,N,Neti]=IT2TSK_NeuroFM_RSVD_StockPricefunc(J_max,Iter,i);
    Net{i,3}=Neti(4).Error;% Error vector
    Resplot(i,:)=min(Resultsi(:,:,i));
    ErrorRec(i,:)=[Neti(4).MSE,Neti(4).NRMSE];
    Net{i,1}=mapminmax('reverse',Neti(1).Data{2},datai_PS);
    Net{i,2}=mapminmax('reverse',Neti(3).Oj4,datai_PS);
end
% c = rand(Iteri,3);       %���������12����ɫ��RGB�����
% c=[255,0,0;
%     255,127,80;%Coral 	ɺ��
%     255,140,0;% 	DarkOrange
%     218,165,32 % 	GoldEnrod������
%     128,128,0; %  Olive��� #808000 
%     127,255,0;%Chartreuse 	���ؾ��� 	#7FFF00 
%     34,139,34;% ForestGreen 	ɭ���� 	#228B22 	
%     47,79,79;%DarkSlateGray 	��ʯ��� 	#2F4F4F 	
%     0,191,255;%DeepSkyBlue 	������ 	#00BFFF 	
%     65,105,225;%RoyalBlue 	�ʾ��� 	#4169E1 	
%     ]/255
dataori=[Net{:,1}];
datapre=[Net{:,2}];
plot(dataori,':'); hold on 
plot(datapre,'-'); hold off
xlim([0,N])
epsname1=strcat('StockPricePredic','.eps' );
saveas(gcf,epsname1,'epsc2')

%% write table
dlmwrite('StockPriceData/StockPriceMSE.tex',ErrorRec','delimiter','&')
TenStockPri=reshape(cell2mat(Net(:,3)),10,[]);
save('StockPriceData/TenStockPriceErrorVec.mat','TenStockPri')


