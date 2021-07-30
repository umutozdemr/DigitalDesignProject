`timescale 1ns / 1ps

module datapath( input logic displayP, displayN, displayC,checkSum,addInput,clk,reset,displayCurrent
,input logic [3:0] adr, input logic [7:0] data, output logic [7:0] display );

logic [7:0] disp_out;
logic [7:0] arr[15:0];
logic [7:0] arr1 = data;
logic [7:0] sum;
logic [7:0] count;
logic myclock;

twoscomplement checksum(arr,clk,checkSum,sum,count);

clock1 myclk(clk,myclock);

always@(posedge myclock)
if(reset)
begin
        arr[0] <= 8'b00000000;
        arr[1] <= 8'b00000001;
        arr[2] <= 8'b00000010;
        arr[3] <= 8'b00000011;
        arr[4] <= 8'b00000100;
        arr[5] <= 8'b00000101;
        arr[6] <= 8'b00000110;
        arr[7] <= 8'b00000111;
        arr[8] <= 8'b00001000;
        arr[9] <= 8'b00001001;
        arr[10] <= 8'b00001010;
        arr[11] <= 8'b00001011;
        arr[12] <= 8'b00001100;
        arr[13] <= 8'b00001101;
        arr[14] <= 8'b00001110;
        arr[15] <= 8'b00001111;
        disp_out = adr;
end

else if(addInput)
begin
arr[adr] = arr1;
end

else if (displayC)
begin
disp_out = count;
end

else if (displayP)
begin
if(adr == 0)
disp_out = arr[15];
else
disp_out = arr[adr-1];
end

else if(displayN)
begin
if(adr == 15)
disp_out = arr[0];
else
disp_out = arr[adr+1];
end

else if (displayCurrent)
begin
disp_out = arr[adr];
end

always_comb
begin

if(checkSum)
begin
display = sum;
end

else
begin
display = disp_out;
end
end

endmodule
