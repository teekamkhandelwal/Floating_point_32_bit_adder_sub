// Code your design here
module float_adder(num1, num2, result, overflow);
  input [31:0] num1, num2;//
  output [31:0] result;
  output overflow; //overflow flag
  reg [31:0] bigNum, smallNum; //to seperate big and small numbers
  wire [23:0] big_fra, small_fra; //to hold fraction part
  wire [7:0] big_ex, small_ex; //to hold exponent part
  wire [8:0] exCheck;//what?
  wire big_sig, small_sig; //to hold signs
  wire [24:0] big_float, small_float; //to hold as float number with integer
  reg [24:0] sign_small_float, shifted_small_float; //preparing small float
  wire [7:0] ex_diff; //difrence between exponentials//taking 6 bto 7/////
  wire [24:0] sum; //sum of numbers with integer parts
  
  assign overflow = (big_sig & small_sig) & ((&big_ex) & (&small_ex)) & sum[24]; //not optimesed
  assign result[31] = big_sig; //result sign same as big sign
  assign result[30:24] = exCheck[7:0]; //get result exponent from exCheck
  assign result[23:0] = (sum[24]) ? sum[24:1] : sum[23:0];//rounddooff

  //decode numbers
  assign {big_sig, big_ex, big_fra} = bigNum;
  assign {small_sig, small_ex, small_fra} = smallNum;
  //add integer parts
  assign big_float = {1'b1, big_fra};
  assign small_float = {1'b1, small_fra};
  assign ex_diff = big_ex - small_ex; //diffrence between exponents
  assign sum = sign_small_float + big_float; //add numbers
  //increase exponent if sum is shifted
  assign exCheck = (sum[24]) ? (big_ex + 1) : big_ex;

  always@* //take small number to exponent of big number
    begin
      case (ex_diff)
        0: shifted_small_float = small_float;
        1: shifted_small_float = (small_float >> 1);
        2: shifted_small_float = (small_float >> 2);
        3: shifted_small_float = (small_float >> 3);
        4: shifted_small_float = (small_float >> 4);
        5: shifted_small_float = (small_float >> 5);
        6: shifted_small_float = (small_float >> 6);
        7: shifted_small_float = (small_float >> 7);
        8: shifted_small_float = (small_float >> 8);
        9: shifted_small_float = (small_float >> 9);
        10: shifted_small_float = (small_float >> 10);
        11: shifted_small_float = (small_float >> 11);
        12: shifted_small_float = (small_float >> 12);
        13: shifted_small_float = (small_float >> 13);
        14: shifted_small_float = (small_float >> 14);
        15: shifted_small_float = (small_float >> 15);
        16: shifted_small_float = (small_float >> 16);
        17: shifted_small_float = (small_float >> 17);
        18: shifted_small_float = (small_float >> 18);
        19: shifted_small_float = (small_float >> 19);
        20: shifted_small_float = (small_float >> 20);
        21: shifted_small_float = (small_float >> 21);
        22: shifted_small_float = (small_float >> 22);
        23: shifted_small_float = (small_float >> 23);
        24: shifted_small_float = (small_float >> 24);
        default: shifted_small_float = 25'b0;
      endcase
    end

  always@* //if signs are diffrent take 2s compliment of small number
    begin
      if(big_sig != small_ex)
        begin
          sign_small_float = ~shifted_small_float + 25'b1;
        end
      else
        begin
          sign_small_float = shifted_small_float;
        end
    end

  always@* //determine big number
    begin
      if(num2[30:24] > num1[30:24])
        begin
          bigNum = num2;
          smallNum = num1;
        end
      else if(num2[30:24] == num1[30:24])
        begin
          if(num2[23:0] > num1[23:0])
            begin
              bigNum = num2;
              smallNum = num1;
            end
          else
            begin
              bigNum = num1;
              smallNum = num2;
            end
        end
      else
        begin
          bigNum = num1;
          smallNum = num2;
        end
    end

endmodule
