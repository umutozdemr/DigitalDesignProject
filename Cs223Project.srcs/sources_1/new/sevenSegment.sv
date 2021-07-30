module sevenSegment(input clk,
                             input [4:0] num0, num1, num2, num3,
                             output logic [7:0] segments,
                             output  logic [3:0] enable_seg );
 reg [17:0] ctr = {18{1'b0}}; 
logic [1:0] isLight; 
always @(posedge clk)
  ctr <= ctr + 1;

assign isLight = ctr[17:16];
logic [4:0] Lights;

  always @(*)
    begin
        case(isLight)
        2'b00: begin
            enable_seg = 4'b1110; 
            Lights = num0;
             end
        2'b01: begin
            enable_seg = 4'b1101; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            Lights = num1;
                end
        2'b10: begin
            enable_seg = 4'b1011; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            Lights = num2 ;
             // the first hex-digit of the 8-bit number
              end
        2'b11: begin
            enable_seg = 4'b0111; 
            // activate LED4 and Deactivate LED2, LED3, LED1
             Lights =  num3;
             // the second hex-digit of the 8-bit number 
               end   
        default:begin
             enable_seg = 4'b000; 
            // activate LED1 and Deactivate LED2, LED3, LED4
           Lights = 5'b00000;
            end
        endcase
    end
     always @(*)
    begin
        case(Lights)
        5'b00000: segments = 8'b1100_0000; // "0"     
        5'b00001: segments = 8'b1111_1001;//" 
        5'b00010: segments = 8'b1010_0100; // "2" 
        5'b00011: segments = 8'b1011_0000; // "3" 
        5'b00100: segments = 8'b1001_1001; // "4" 
        5'b00101: segments = 8'b1001_0010; // "5" 
        5'b00110: segments = 8'b1000_0010; // "6" 
        5'b00111: segments = 8'b1111_1000; // "7" 
        5'b01000: segments = 8'b1000_0000; // "8"     
        5'b01001: segments = 8'b1001_0000; // "9" 
        5'b01010: segments = 8'b1000_1000; // "A" 
        5'b01011: segments = 8'b1000_0011; // "B" 
        5'b01100: segments = 8'b1100_0110; // "C" 
        5'b01101: segments = 8'b1010_0001; // "D"
        5'b01110: segments = 8'b1000_0110; // "E"  
        5'b01111: segments = 8'b1000_1110; // "F" 
        5'b10000: segments = 8'b1011_0111; // "=" 
        5'b10001: segments = 8'b1011_1111; // "-" 
        default: segments = 8'b1111_1111; // ""
        endcase
    end
endmodule
