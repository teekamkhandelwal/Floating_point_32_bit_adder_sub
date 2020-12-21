module fp_addsub(sum, datain_a, datain_b );
input [31:0] datain_a, datain_b;
output reg [31:0] sum;
  
reg sumneg;//output sign bit
  reg [7:0] sumexp;//output exponent register
  reg [24:0] summanti;//output mantansa
  reg [23:0] temp_result;//temperary register for manaansa result after addition between
  reg [31:0] a,b;//two input bit 
  reg [23:0] amanti, bmanti;//input bits mantansa part
  reg [7:0] aexp, bexp;//input exponent bits
reg aneg, bneg;//input sign bit
  
wire spl,abit;//abit not understand 
  reg [7:0] diff;//differeence of exponent after comparision
wire [31:0] a_temp;
  
  assign abit = ~datain_a[31];//it is used when the  input a sign bit is different 
  assign a_temp = {abit,datain_a[30:0]};//used when the sign bit is differnet 
  
//assign spl= ~(datain_a[31] |datain_b[31]);
  assign spl = ~(datain_a[31]^datain_b[31]);//exnor of two sign bits of inputs for resukt operation
//always @ (datain_a, datain_b)
  
always @ (*)
  //step 1
begin
  if (a_temp==datain_b)//condition checking for solving operation
sum = 32'b0;
else
  //step 2
begin
  if(datain_a[30:23]< datain_b[30:23])// step 2 comparision of exponents condition for exponent b is greater then a
begin
a=datain_b;
b=datain_a;
end
else//input a is greater then b
begin
a= datain_a;
b= datain_b;
end
 //seperation of exponent, mantansa and sign bit step 3 
aneg =a[31];
bneg=b[31];
aexp= a[30:23];
bexp= b[30:23];
amanti= {1'b1, a[22:0]};
bmanti= {1'b1, b[22:0]};
diff = aexp-bexp;
 //step 4 
bmanti = bmanti>>diff;
if(aneg)
amanti= -amanti;
if(bneg)
bmanti= -bmanti;
  //addition step 5
summanti = amanti+ bmanti;
sumneg = aneg;
if(sumneg==1)
begin
summanti = -summanti;
temp_result = summanti[23:0];
end
else
  //step 6 when fracion part is like 111010
temp_result = summanti[23:0];
if(spl==1)
begin
  if (summanti[24]==1)//overflow
begin
sumexp = aexp+1;
sum[22:0] = summanti[23:1];
end
end
else
begin:A//when fraction part is 000111001
integer i = 0;
temp_result = summanti[23:0];
while ((temp_result[23]==0)&(i<23))
begin
temp_result = temp_result<<1;//underflow
aexp = aexp-1;
i=i+1;
end
sumexp = aexp;
sum[22:0]= temp_result[22:0];
end
sum[31] = sumneg;
sum[30:23] = sumexp;
end
end
endmodule
