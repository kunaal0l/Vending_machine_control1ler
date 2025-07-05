`timescale 1ns / 1ps
module vending_machine(
    input clk,
    input reset,
    input [1:0] coin,       // 00: $0, 01: $5, 10: $10
    output reg out,
    output reg [1:0] change // in $1 units
);

parameter s0=2'b00;
parameter s1=2'b01;
parameter s2=2'b10;

reg [1:0]current_state,next_state;
always @(posedge clk)
    begin
        if(reset)
            begin
                current_state=0;
                next_state=0;
                change=2'd0;
            end
        else
            begin
                current_state=next_state;
                case(current_state)
                    s0:
                    begin
                        if(coin==0)
                            begin
                            next_state=s0;
                            out=0;
                            change=0;
                            end
                       else if(coin==2'b01)
                         begin
                         next_state=s1;
                         out=0;
                         change=0;
                         end
                       else
                         begin
                         next_state=s2;
                         out=0;
                         change=0;
                         end  
                    end
                    s1:
                    begin
                        if(coin==0)
                            begin
                            next_state=s0;
                            out=0;
                            change=5;
                            end
                       else if(coin==2'b01)
                         begin
                         next_state=s2;
                         out=0;
                         change=0;
                         end
                       else
                         begin
                         next_state=s0;
                         out=1;
                         change=0;
                         end  
                    end
                    s2:
                    begin
                        if(coin==0)
                            begin
                            next_state=s0;
                            out=0;
                            change=10;
                            end
                       else if(coin==2'b01)
                         begin
                         next_state=s0;
                         out=1;
                         change=0;
                         end
                       else
                         begin
                         next_state=s0;
                         out=1;
                         change=5;
                         end  
                    end
//                    default:
                endcase
           end
    end

   
endmodule
