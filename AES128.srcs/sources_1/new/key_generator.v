`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 09:10:52 AM
// Design Name:
// Module Name: key_generator
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


module key_generator(
    input clk, /* Clock */
    input en, /* Enable */
    input [127:0] key, /* Input Key */
    output reg keyReady, /* Is Key Ready ? */

    input [2:0] round, /* Round Number */
    output [127:0] roundKey
    );

    /**** Parameters ****/
    parameter IDLE = 0;
    parameter MAP       = 1;
    parameter ROT_AND_SUB_BYTE_GET_RCON  = 2;
    parameter XOR1       = 3;
    parameter XOR2       = 4;

    /**** Locals ****/
    reg [7:0] finalKeys [0:3][0:43];
    reg [7:0] keyWordIndex = 8'h0;

    reg [7:0] localRound = 8'h0;
    wire [7:0] localRcon;
    wire [7:0] localSubByte [0:3];

    reg [2:0] STATE = IDLE;

    reg [7:0]inByte1;
    reg [7:0]inByte2;
    reg [7:0]inByte3;
    reg [7:0]inByte4;

    integer i, j;

    reg disableBlock;

    /**** Instantiatons ****/
    sbox sbox1 (.inByte(inByte1), .subByte(localSubByte[0]));
    sbox sbox2 (.inByte(inByte2), .subByte(localSubByte[1]));
    sbox sbox3 (.inByte(inByte3), .subByte(localSubByte[2]));
    sbox sbox4 (.inByte(inByte4), .subByte(localSubByte[3]));

    rcon rcon1 (.round(localRound), .rcon(localRcon));

    /**** Procedural Blocks ****/
    always @(posedge clk) begin
        if(en & !disableBlock) begin
            case (STATE)
                IDLE: begin
                    {keyReady, disableBlock} <= (keyWordIndex == 44) ? 2'b11 : 8'b00;
                end
                MAP: begin
                    finalKeys[0][0] <= key[127:120];
                    finalKeys[0][1] <= key[119:112];
                    finalKeys[0][2] <= key[111:104];
                    finalKeys[0][3] <= key[103:96];
                    finalKeys[1][0] <= key[95:88];
                    finalKeys[1][1] <= key[87:80];
                    finalKeys[1][2] <= key[79:72];
                    finalKeys[1][3] <= key[71:64];
                    finalKeys[2][0] <= key[63:56];
                    finalKeys[2][1] <= key[55:48];
                    finalKeys[2][2] <= key[47:40];
                    finalKeys[2][3] <= key[39:32];
                    finalKeys[3][0] <= key[31:24];
                    finalKeys[3][1] <= key[23:16];
                    finalKeys[3][2] <= key[15:8];
                    finalKeys[3][3] <= key[7:0];

                    keyWordIndex <= keyWordIndex + 8'h4;
                    STATE <= ROT_AND_SUB_BYTE_GET_RCON;
                end
                ROT_AND_SUB_BYTE_GET_RCON: begin
                    /* Sub bytes of W(i-1) with rotated input to subSbytes */
                    inByte1 <= finalKeys[1][keyWordIndex - 8'h1];
                    inByte2 <= finalKeys[2][keyWordIndex - 8'h1];
                    inByte3 <= finalKeys[3][keyWordIndex - 8'h1];
                    inByte4 <= finalKeys[0][keyWordIndex - 8'h1];

                    /* Increment Round */
                    localRound <= localRound + 1;

                    STATE <= XOR1;
                end
                XOR1: begin
                    finalKeys[0][keyWordIndex] <= finalKeys[0][keyWordIndex - 8'h4] ^ localSubByte[0] ^ localRcon;
                    finalKeys[1][keyWordIndex] <= finalKeys[1][keyWordIndex - 8'h4] ^ localSubByte[1] ^ 8'h0;
                    finalKeys[2][keyWordIndex] <= finalKeys[2][keyWordIndex - 8'h4] ^ localSubByte[2] ^ 8'h0;
                    finalKeys[3][keyWordIndex] <= finalKeys[3][keyWordIndex - 8'h4] ^ localSubByte[3] ^ 8'h0;

                    keyWordIndex <= keyWordIndex + 8'h1;
                    STATE <= XOR2;
                end
                default: begin
                end
            endcase
        end
        else begin

        end
    end

    always @(STATE) begin
        if (STATE == XOR2) begin
            for (i = 0; i < 3; i = i + 1) begin
                finalKeys[0][keyWordIndex] = finalKeys[0][keyWordIndex - 8'h4] ^ finalKeys[0][keyWordIndex - 8'h1];
                finalKeys[1][keyWordIndex] = finalKeys[1][keyWordIndex - 8'h4] ^ finalKeys[1][keyWordIndex - 8'h1];
                finalKeys[2][keyWordIndex] = finalKeys[2][keyWordIndex - 8'h4] ^ finalKeys[2][keyWordIndex - 8'h1];
                finalKeys[3][keyWordIndex] = finalKeys[3][keyWordIndex - 8'h4] ^ finalKeys[3][keyWordIndex - 8'h1];
                keyWordIndex = keyWordIndex + 1;
            end
            STATE = (keyWordIndex == 44) ? IDLE : ROT_AND_SUB_BYTE_GET_RCON;
        end
    end

    always @(posedge en) begin
        STATE <= MAP;
        keyWordIndex <= 8'b0;
        keyReady <= 8'b0;
        disableBlock = 1'b0;
        localRound <= 8'b0;

        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 44; j = j + 1) begin
                finalKeys[i][j] <= 8'b0;
            end
        end
    end

endmodule
