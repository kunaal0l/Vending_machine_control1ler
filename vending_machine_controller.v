`timescale 1ns / 1ps

module v_machine(
    input clk,
    input reset,
    input select_products,       // 0: chocolate ($15), 1: drink ($10)
    input [1:0] coin,            // 00: $0, 01: $5, 10: $10
    output reg out,
    output reg [3:0] change      // in $1 units
);

    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter choco = 1'b0;      // Chocolate costs $15
    parameter drink = 1'b1;      // Drink costs $10

    reg [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= s0;
            next_state <= s0;
            change <= 2'd0;
            out <= 0;
        end else begin
            current_state <= next_state;

            case (select_products)

                choco: begin
                    case (current_state)
                        s0: begin
                            if (coin == 2'b00) begin
                                next_state <= s0;
                                out <= 0;
                                change <= 0;
                            end else if (coin == 2'b01) begin
                                next_state <= s1;
                                out <= 0;
                                change <= 0;
                            end else begin
                                next_state <= s2;
                                out <= 0;
                                change <= 0;
                            end
                        end

                        s1: begin
                            if (coin == 2'b00) begin
                                next_state <= s0;
                                out <= 0;
                                change <= 3'd5;
                            end else if (coin == 2'b01) begin
                                next_state <= s2;
                                out <= 0;
                                change <= 0;
                            end else begin
                                next_state <= s0;
                                out <= 1;
                                change <= 0;
                            end
                        end

                        s2: begin
                            if (coin == 2'b00) begin
                                next_state <= s0;
                                out <= 0;
                                change <= 4'd10;
                            end else if (coin == 2'b01) begin
                                next_state <= s0;
                                out <= 1;
                                change <= 0;
                            end else begin
                                next_state <= s0;
                                out <= 1;
                                change <= 3'd5;
                            end
                        end
                    endcase
                end

                drink: begin
                    case (current_state)
                        s0: begin
                            if (coin == 2'b00) begin
                                next_state <= s0;
                                out <= 0;
                                change <= 0;
                            end else if (coin == 2'b01) begin
                                next_state <= s1;
                                out <= 0;
                                change <= 0;
                            end else begin
                                next_state <= s2;
                                out <= 1;
                                change <= 0;
                            end
                        end

                        s1: begin
                            if (coin == 2'b00) begin
                                next_state <= s0;
                                out <= 0;
                                change <= 3'd5;
                            end else if (coin == 2'b01) begin
                                next_state <= s2;
                                out <= 1;
                                change <= 0;
                            end else begin
                                next_state <= s0;
                                out <= 1;
                                change <= 3'd5;
                            end
                        end
                    endcase
                end

            endcase
        end
    end

endmodule
