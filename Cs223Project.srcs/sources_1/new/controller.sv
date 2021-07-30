`timescale 1ns / 1ps

module controller( input logic [3:0]adr_in, input logic displayC, displayN,
 displayP,displayCurrent, addInput, checkSum, reset,clk, input logic [7:0] data_in,
  output logic [3:0] theenable ,adrled, output logic [7:0] thesegment,dataled );

typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7} statetype;
statetype state, nextstate;

logic addInput1, displayC1, displayN1, displayP1, checkSum1, displayCurrent1;
logic [3:0] currentAdr, prevAdr, enable_seg;
logic[7:0] display;
logic[5:0] num0,num1,num2,num3;       
logic[7:0] segments; 

datapath dp( displayP1, displayN1, displayC1,checkSum1,addInput,clk,reset,
displayCurrent1, adr_in,  data_in, display );
sevenSegment ss(clk, num0, num1, num2, num3, segments, enable_seg);

always_ff @ (posedge clk or posedge reset)     
        
if(reset ==1 )state <= S0;
else state <= nextstate;  
                                  
always_comb                           
case (state)  
                        
S0: 
begin
displayC1 = 0;
displayCurrent1 = 0;
displayN1 = 0;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 0;
currentAdr = adr_in;  

nextstate = S1;
end  
         
S1: 
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 1;
displayN1 = 0;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 0;
thesegment = segments;
    theenable = enable_seg;
if(addInput)nextstate = S2;              
else if(checkSum)nextstate = S6;   
else if(displayC)nextstate = S7;      
else if(displayN)nextstate = S4;
else if(displayP)nextstate = S3;
else if(currentAdr != prevAdr)nextstate = S5;
else nextstate = S1;
end   
                
S2:
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 0;
displayN1 = 0;
displayP1 = 0;
addInput1 = 1;
checkSum1 = 0;

 nextstate = S1; 
 end
 
S3:
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 0;
displayN1 = 0;
displayP1 = 1;
addInput1 = 0;
checkSum1 = 0;

nextstate = S1;
end   
                
S4:
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 0;
displayN1 = 1;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 0;

nextstate = S1;
end   
                
S5: 
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 1;
displayN1 = 0;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 0;

nextstate = S1;
end 
                  
S6: 
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 0;
displayCurrent1 = 0;
displayN1 = 0;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 1;
thesegment = segments;
    theenable = enable_seg;
nextstate = S1;                  
end


S7: 
begin
prevAdr = currentAdr;
currentAdr = adr_in;
displayC1 = 1;
displayCurrent1 = 0;
displayN1 = 0;
displayP1 = 0;
addInput1 = 0;
checkSum1 = 0;
thesegment = segments;
    theenable = enable_seg;
nextstate = S1;                  
end                                      
default: nextstate = S0;              
endcase

always@(*)
begin
if(displayC)
begin 
num0 = 5'b01100;
num1 = 5'b10000;
num2 = display[7:4];
num3 = display[3:0];
end
else if(checkSum)begin
num0 =5'b01100;
num1 =5'b10001;
num2 =display[7:4];
num3 =display[3:0];
end
else 
begin 
num0=adr_in;
num1=5'b10001;
num2 =display[7:4];
num3 =display[3:0];
end
end


assign adrled = adr_in;
assign dataled = data_in;
endmodule