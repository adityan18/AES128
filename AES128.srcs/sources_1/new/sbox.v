`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/18/2024 10:32:07 AM
// Design Name:
// Module Name: sbox
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


module sbox(
    input [7:0] inByte, /*Input Bytes to be substituted */
    output [7:0] subByte /* Substitued Bytes */
    );

    /**** Locals ****/
    reg [7:0] localSubByte = 8'h0;

    /**** Procedural Blocks ****/
    always @(inByte) begin
        case (inByte)
            8'h00: localSubByte = 8'h63;
            8'h01: localSubByte = 8'h7c;
            8'h02: localSubByte = 8'h77;
            8'h03: localSubByte = 8'h7b;
            8'h04: localSubByte = 8'hf2;
            8'h05: localSubByte = 8'h6b;
            8'h06: localSubByte = 8'h6f;
            8'h07: localSubByte = 8'hc5;
            8'h08: localSubByte = 8'h30;
            8'h09: localSubByte = 8'h01;
            8'h0a: localSubByte = 8'h67;
            8'h0b: localSubByte = 8'h2b;
            8'h0c: localSubByte = 8'hfe;
            8'h0d: localSubByte = 8'hd7;
            8'h0e: localSubByte = 8'hab;
            8'h0f: localSubByte = 8'h76;
            8'h10: localSubByte = 8'hca;
            8'h11: localSubByte = 8'h82;
            8'h12: localSubByte = 8'hc9;
            8'h13: localSubByte = 8'h7d;
            8'h14: localSubByte = 8'hfa;
            8'h15: localSubByte = 8'h59;
            8'h16: localSubByte = 8'h47;
            8'h17: localSubByte = 8'hf0;
            8'h18: localSubByte = 8'had;
            8'h19: localSubByte = 8'hd4;
            8'h1a: localSubByte = 8'ha2;
            8'h1b: localSubByte = 8'haf;
            8'h1c: localSubByte = 8'h9c;
            8'h1d: localSubByte = 8'ha4;
            8'h1e: localSubByte = 8'h72;
            8'h1f: localSubByte = 8'hc0;
            8'h20: localSubByte = 8'hb7;
            8'h21: localSubByte = 8'hfd;
            8'h22: localSubByte = 8'h93;
            8'h23: localSubByte = 8'h26;
            8'h24: localSubByte = 8'h36;
            8'h25: localSubByte = 8'h3f;
            8'h26: localSubByte = 8'hf7;
            8'h27: localSubByte = 8'hcc;
            8'h28: localSubByte = 8'h34;
            8'h29: localSubByte = 8'ha5;
            8'h2a: localSubByte = 8'he5;
            8'h2b: localSubByte = 8'hf1;
            8'h2c: localSubByte = 8'h71;
            8'h2d: localSubByte = 8'hd8;
            8'h2e: localSubByte = 8'h31;
            8'h2f: localSubByte = 8'h15;
            8'h30: localSubByte = 8'h04;
            8'h31: localSubByte = 8'hc7;
            8'h32: localSubByte = 8'h23;
            8'h33: localSubByte = 8'hc3;
            8'h34: localSubByte = 8'h18;
            8'h35: localSubByte = 8'h96;
            8'h36: localSubByte = 8'h05;
            8'h37: localSubByte = 8'h9a;
            8'h38: localSubByte = 8'h07;
            8'h39: localSubByte = 8'h12;
            8'h3a: localSubByte = 8'h80;
            8'h3b: localSubByte = 8'he2;
            8'h3c: localSubByte = 8'heb;
            8'h3d: localSubByte = 8'h27;
            8'h3e: localSubByte = 8'hb2;
            8'h3f: localSubByte = 8'h75;
            8'h40: localSubByte = 8'h09;
            8'h41: localSubByte = 8'h83;
            8'h42: localSubByte = 8'h2c;
            8'h43: localSubByte = 8'h1a;
            8'h44: localSubByte = 8'h1b;
            8'h45: localSubByte = 8'h6e;
            8'h46: localSubByte = 8'h5a;
            8'h47: localSubByte = 8'ha0;
            8'h48: localSubByte = 8'h52;
            8'h49: localSubByte = 8'h3b;
            8'h4a: localSubByte = 8'hd6;
            8'h4b: localSubByte = 8'hb3;
            8'h4c: localSubByte = 8'h29;
            8'h4d: localSubByte = 8'he3;
            8'h4e: localSubByte = 8'h2f;
            8'h4f: localSubByte = 8'h84;
            8'h50: localSubByte = 8'h53;
            8'h51: localSubByte = 8'hd1;
            8'h52: localSubByte = 8'h00;
            8'h53: localSubByte = 8'hed;
            8'h54: localSubByte = 8'h20;
            8'h55: localSubByte = 8'hfc;
            8'h56: localSubByte = 8'hb1;
            8'h57: localSubByte = 8'h5b;
            8'h58: localSubByte = 8'h6a;
            8'h59: localSubByte = 8'hcb;
            8'h5a: localSubByte = 8'hbe;
            8'h5b: localSubByte = 8'h39;
            8'h5c: localSubByte = 8'h4a;
            8'h5d: localSubByte = 8'h4c;
            8'h5e: localSubByte = 8'h58;
            8'h5f: localSubByte = 8'hcf;
            8'h60: localSubByte = 8'hd0;
            8'h61: localSubByte = 8'hef;
            8'h62: localSubByte = 8'haa;
            8'h63: localSubByte = 8'hfb;
            8'h64: localSubByte = 8'h43;
            8'h65: localSubByte = 8'h4d;
            8'h66: localSubByte = 8'h33;
            8'h67: localSubByte = 8'h85;
            8'h68: localSubByte = 8'h45;
            8'h69: localSubByte = 8'hf9;
            8'h6a: localSubByte = 8'h02;
            8'h6b: localSubByte = 8'h7f;
            8'h6c: localSubByte = 8'h50;
            8'h6d: localSubByte = 8'h3c;
            8'h6e: localSubByte = 8'h9f;
            8'h6f: localSubByte = 8'ha8;
            8'h70: localSubByte = 8'h51;
            8'h71: localSubByte = 8'ha3;
            8'h72: localSubByte = 8'h40;
            8'h73: localSubByte = 8'h8f;
            8'h74: localSubByte = 8'h92;
            8'h75: localSubByte = 8'h9d;
            8'h76: localSubByte = 8'h38;
            8'h77: localSubByte = 8'hf5;
            8'h78: localSubByte = 8'hbc;
            8'h79: localSubByte = 8'hb6;
            8'h7a: localSubByte = 8'hda;
            8'h7b: localSubByte = 8'h21;
            8'h7c: localSubByte = 8'h10;
            8'h7d: localSubByte = 8'hff;
            8'h7e: localSubByte = 8'hf3;
            8'h7f: localSubByte = 8'hd2;
            8'h80: localSubByte = 8'hcd;
            8'h81: localSubByte = 8'h0c;
            8'h82: localSubByte = 8'h13;
            8'h83: localSubByte = 8'hec;
            8'h84: localSubByte = 8'h5f;
            8'h85: localSubByte = 8'h97;
            8'h86: localSubByte = 8'h44;
            8'h87: localSubByte = 8'h17;
            8'h88: localSubByte = 8'hc4;
            8'h89: localSubByte = 8'ha7;
            8'h8a: localSubByte = 8'h7e;
            8'h8b: localSubByte = 8'h3d;
            8'h8c: localSubByte = 8'h64;
            8'h8d: localSubByte = 8'h5d;
            8'h8e: localSubByte = 8'h19;
            8'h8f: localSubByte = 8'h73;
            8'h90: localSubByte = 8'h60;
            8'h91: localSubByte = 8'h81;
            8'h92: localSubByte = 8'h4f;
            8'h93: localSubByte = 8'hdc;
            8'h94: localSubByte = 8'h22;
            8'h95: localSubByte = 8'h2a;
            8'h96: localSubByte = 8'h90;
            8'h97: localSubByte = 8'h88;
            8'h98: localSubByte = 8'h46;
            8'h99: localSubByte = 8'hee;
            8'h9a: localSubByte = 8'hb8;
            8'h9b: localSubByte = 8'h14;
            8'h9c: localSubByte = 8'hde;
            8'h9d: localSubByte = 8'h5e;
            8'h9e: localSubByte = 8'h0b;
            8'h9f: localSubByte = 8'hdb;
            8'ha0: localSubByte = 8'he0;
            8'ha1: localSubByte = 8'h32;
            8'ha2: localSubByte = 8'h3a;
            8'ha3: localSubByte = 8'h0a;
            8'ha4: localSubByte = 8'h49;
            8'ha5: localSubByte = 8'h06;
            8'ha6: localSubByte = 8'h24;
            8'ha7: localSubByte = 8'h5c;
            8'ha8: localSubByte = 8'hc2;
            8'ha9: localSubByte = 8'hd3;
            8'haa: localSubByte = 8'hac;
            8'hab: localSubByte = 8'h62;
            8'hac: localSubByte = 8'h91;
            8'had: localSubByte = 8'h95;
            8'hae: localSubByte = 8'he4;
            8'haf: localSubByte = 8'h79;
            8'hb0: localSubByte = 8'he7;
            8'hb1: localSubByte = 8'hc8;
            8'hb2: localSubByte = 8'h37;
            8'hb3: localSubByte = 8'h6d;
            8'hb4: localSubByte = 8'h8d;
            8'hb5: localSubByte = 8'hd5;
            8'hb6: localSubByte = 8'h4e;
            8'hb7: localSubByte = 8'ha9;
            8'hb8: localSubByte = 8'h6c;
            8'hb9: localSubByte = 8'h56;
            8'hba: localSubByte = 8'hf4;
            8'hbb: localSubByte = 8'hea;
            8'hbc: localSubByte = 8'h65;
            8'hbd: localSubByte = 8'h7a;
            8'hbe: localSubByte = 8'hae;
            8'hbf: localSubByte = 8'h08;
            8'hc0: localSubByte = 8'hba;
            8'hc1: localSubByte = 8'h78;
            8'hc2: localSubByte = 8'h25;
            8'hc3: localSubByte = 8'h2e;
            8'hc4: localSubByte = 8'h1c;
            8'hc5: localSubByte = 8'ha6;
            8'hc6: localSubByte = 8'hb4;
            8'hc7: localSubByte = 8'hc6;
            8'hc8: localSubByte = 8'he8;
            8'hc9: localSubByte = 8'hdd;
            8'hca: localSubByte = 8'h74;
            8'hcb: localSubByte = 8'h1f;
            8'hcc: localSubByte = 8'h4b;
            8'hcd: localSubByte = 8'hbd;
            8'hce: localSubByte = 8'h8b;
            8'hcf: localSubByte = 8'h8a;
            8'hd0: localSubByte = 8'h70;
            8'hd1: localSubByte = 8'h3e;
            8'hd2: localSubByte = 8'hb5;
            8'hd3: localSubByte = 8'h66;
            8'hd4: localSubByte = 8'h48;
            8'hd5: localSubByte = 8'h03;
            8'hd6: localSubByte = 8'hf6;
            8'hd7: localSubByte = 8'h0e;
            8'hd8: localSubByte = 8'h61;
            8'hd9: localSubByte = 8'h35;
            8'hda: localSubByte = 8'h57;
            8'hdb: localSubByte = 8'hb9;
            8'hdc: localSubByte = 8'h86;
            8'hdd: localSubByte = 8'hc1;
            8'hde: localSubByte = 8'h1d;
            8'hdf: localSubByte = 8'h9e;
            8'he0: localSubByte = 8'he1;
            8'he1: localSubByte = 8'hf8;
            8'he2: localSubByte = 8'h98;
            8'he3: localSubByte = 8'h11;
            8'he4: localSubByte = 8'h69;
            8'he5: localSubByte = 8'hd9;
            8'he6: localSubByte = 8'h8e;
            8'he7: localSubByte = 8'h94;
            8'he8: localSubByte = 8'h9b;
            8'he9: localSubByte = 8'h1e;
            8'hea: localSubByte = 8'h87;
            8'heb: localSubByte = 8'he9;
            8'hec: localSubByte = 8'hce;
            8'hed: localSubByte = 8'h55;
            8'hee: localSubByte = 8'h28;
            8'hef: localSubByte = 8'hdf;
            8'hf0: localSubByte = 8'h8c;
            8'hf1: localSubByte = 8'ha1;
            8'hf2: localSubByte = 8'h89;
            8'hf3: localSubByte = 8'h0d;
            8'hf4: localSubByte = 8'hbf;
            8'hf5: localSubByte = 8'he6;
            8'hf6: localSubByte = 8'h42;
            8'hf7: localSubByte = 8'h68;
            8'hf8: localSubByte = 8'h41;
            8'hf9: localSubByte = 8'h99;
            8'hfa: localSubByte = 8'h2d;
            8'hfb: localSubByte = 8'h0f;
            8'hfc: localSubByte = 8'hb0;
            8'hfd: localSubByte = 8'h54;
            8'hfe: localSubByte = 8'hbb;
            8'hff: localSubByte = 8'h16;
        endcase
    end


    /**** Assignments ****/
    assign subByte = localSubByte;
endmodule
