`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2020 16:20:03
// Design Name: 
// Module Name: twoscompelent
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module twoscomplement(input logic[7:0] arr[15:0] ,input logic clk,checkSum,
//                    output logic[7:0] sum, count );
//       logic [7:0] allSum = 0;
//       int count2 = 0;
       
       
//       always @( posedge clk)begin
//    for(int i = 0; i < 16 ; i++) begin
//    allSum += arr[i];
//    count2++;
//    end                
    
//    end              
//      assign count = count2;  
//    assign sum = ~allSum + 1;             
//endmodule
module twoscomplement(input logic[7:0] arr[15:0] ,input logic clk,checkSum,output logic[7:0] sum, count );

logic[7:0] beforesum = 0;
int i = 17;

always @( posedge clk)begin
if(checkSum)begin 

beforesum = 0;
count = 0;
i = 0;
end
else if( i<16)
begin
beforesum = beforesum + arr[i];
i = i +1;
count= count+1;
end

end
assign sum = ~beforesum + 1 ; 

endmodule