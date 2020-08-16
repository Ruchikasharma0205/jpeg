A1=int16(imread('kodim03.png')); % read input image
A=rgb2gray(A1);
%imshow(A);
[r,c]=size(A);
p=ceil(r/8)*8;
q=ceil(c/8)*8;
I=int16(zeros(p,q));
out=(zeros(p,q));
res=int16(zeros(p,q));
I(1:r,1:c)=A;
I1=I;
% level shifting of pixels
I=I-128;
% normalization matrix of block size 8x8
Q = [ 16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];
% normalization matrix of block size 4x4
Q1=[16 11 10 16 0 0 0 0 ;
12 12 14 19 0 0 0 0;
14 13 16 24 0 0 0 0;
14 17 22 29 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0];
% normalization matrix of block size 1x1
Q2=[16 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0];
% normalization matrix of block size 1x1
Q3=[16 11 0 0 0 0 0 0;
12 12 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0];
% another normalization matrix
Q4= [17 18 24 47 99 99 99 99;
18 21 26 66 99 99 99 99;
24 26 56 99 99 99 99 99;
47 66 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99];

for i=1:8:p
for j=1:8:q
B=I(i:i+7,j:j+7);
B1=dct2(B);
B1=round(B1./Q);
out(i:i+7,j:j+7)=B1;
end
end

for i=1:8:p
for j=1:8:q
C=out(i:i+7,j:j+7);
C=round(C.*Q);
C1=idct2(C);
res(i:i+7,j:j+7)=C1;
end
end


res=res+128;

imshow(uint8(res));
rmse=sqrt(immse(I1,res));
disp(rmse);

