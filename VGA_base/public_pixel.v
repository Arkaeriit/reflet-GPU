/*
ROM containing the font Public Pixel.
Made by GGBotNet under the license Creative Commons Zero v1.0 Universal.
Accepts ISO/IEC 8859-1 encoded characters as input?
*/

module public_pixel (
    input [7:0] char,
    input [$clog2(64)-1:0] index,
    output is_foreground
    );

    reg [63:0] font_char;
    wire [63:0] shift = font_char >> index;
    assign is_foreground = shift[0];
    
    always @ (char)
        case(char)
            8'h21 : font_char = 64'h000C1E1E1E0C000C;
            8'h22 : font_char = 64'h0036362412000000;
            8'h23 : font_char = 64'h00367F3636367F36;
            8'h24 : font_char = 64'h00087E0B3E683F08;
            8'h25 : font_char = 64'h00426532182C5623;
            8'h26 : font_char = 64'h000E1B0E5B73633E;
            8'h27 : font_char = 64'h000C0C0804000000;
            8'h28 : font_char = 64'h00380C0606060C38;
            8'h29 : font_char = 64'h000E18303030180E;
            8'h2A : font_char = 64'h00361C3600000000;
            8'h2B : font_char = 64'h00000008083E0808;
            8'h2C : font_char = 64'h000000000C0C0804;
            8'h2D : font_char = 64'h00000000003E0000;
            8'h2E : font_char = 64'h0000000000000C0C;
            8'h2F : font_char = 64'h002030180C060301;
            8'h30 : font_char = 64'h003E73636363673E;
            8'h31 : font_char = 64'h001E18181818187E;
            8'h32 : font_char = 64'h003E63301C06037F;
            8'h33 : font_char = 64'h003E63603C60633E;
            8'h34 : font_char = 64'h00786C66637F6060;
            8'h35 : font_char = 64'h007F033F6060633E;
            8'h36 : font_char = 64'h003E63033F63633E;
            8'h37 : font_char = 64'h007F6330180C0603;
            8'h38 : font_char = 64'h003E63633E63633E;
            8'h39 : font_char = 64'h003E63637E60633E;
            8'h3A : font_char = 64'h0000000C0C000C0C;
            8'h3B : font_char = 64'h0000000C0C000C08;
            8'h3C : font_char = 64'h000000381C0E1C38;
            8'h3D : font_char = 64'h000000003E003E00;
            8'h3E : font_char = 64'h0000000E1C381C0E;
            8'h3F : font_char = 64'h003E63603C0C000C;
            8'h40 : font_char = 64'h003E636B6B3B033E;
            8'h41 : font_char = 64'h001C3663637F6363;
            8'h42 : font_char = 64'h003F63633F63633F;
            8'h43 : font_char = 64'h003E63030303633E;
            8'h44 : font_char = 64'h001F33636363331F;
            8'h45 : font_char = 64'h007F03031F03037F;
            8'h46 : font_char = 64'h007F03031F030303;
            8'h47 : font_char = 64'h007E03037B63637E;
            8'h48 : font_char = 64'h006363637F636363;
            8'h49 : font_char = 64'h007E18181818187E;
            8'h4A : font_char = 64'h007860606063633E;
            8'h4B : font_char = 64'h0063331B0F1B3363;
            8'h4C : font_char = 64'h000303030303037F;
            8'h4D : font_char = 64'h0063777F6B636363;
            8'h4E : font_char = 64'h0063676F7B736363;
            8'h4F : font_char = 64'h003E63636363633E;
            8'h50 : font_char = 64'h003F63633F030303;
            8'h51 : font_char = 64'h003E6363637B335E;
            8'h52 : font_char = 64'h003F63633F1B3363;
            8'h53 : font_char = 64'h003E63033E60633E;
            8'h54 : font_char = 64'h007E181818181818;
            8'h55 : font_char = 64'h006363636363633E;
            8'h56 : font_char = 64'h0063636363361C08;
            8'h57 : font_char = 64'h0063636B7F776363;
            8'h58 : font_char = 64'h0063773E1C3E7763;
            8'h59 : font_char = 64'h006666663C181818;
            8'h5A : font_char = 64'h007F70381C0E077F;
            8'h5B : font_char = 64'h003E06060606063E;
            8'h5C : font_char = 64'h0002060C18306040;
            8'h5D : font_char = 64'h003E30303030303E;
            8'h5E : font_char = 64'h00081C3663000000;
            8'h5F : font_char = 64'h000000000000007F;
            8'h60 : font_char = 64'h0004080000000000;
            8'h61 : font_char = 64'h0000003E607E637E;
            8'h62 : font_char = 64'h0003033F6363633F;
            8'h63 : font_char = 64'h0000003E6303633E;
            8'h64 : font_char = 64'h0060607E6363637E;
            8'h65 : font_char = 64'h0000003E637F033E;
            8'h66 : font_char = 64'h003C0C7F0C0C0C0C;
            8'h67 : font_char = 64'h0000007E637E603E;
            8'h68 : font_char = 64'h0003033F63636363;
            8'h69 : font_char = 64'h0018001E1818187F;
            8'h6A : font_char = 64'h006000606060633E;
            8'h6B : font_char = 64'h00030363331F3363;
            8'h6C : font_char = 64'h0003030303030E78;
            8'h6D : font_char = 64'h0000003F6B6B6B6B;
            8'h6E : font_char = 64'h0000003F63636363;
            8'h6F : font_char = 64'h0000003E6363633E;
            8'h70 : font_char = 64'h0000003F633F0303;
            8'h71 : font_char = 64'h0000007E637E6060;
            8'h72 : font_char = 64'h0000003B67030303;
            8'h73 : font_char = 64'h0000007E037F603F;
            8'h74 : font_char = 64'h000C0C7F0C0C0C7C;
            8'h75 : font_char = 64'h000000636363633E;
            8'h76 : font_char = 64'h0000006363361C08;
            8'h77 : font_char = 64'h000000636B6B7F36;
            8'h78 : font_char = 64'h000000773E1C3E77;
            8'h79 : font_char = 64'h0000006363361C0F;
            8'h7A : font_char = 64'h0000007F381C0E7F;
            8'h7B : font_char = 64'h00380C0C0E0C0C38;
            8'h7C : font_char = 64'h000C0C0C0C0C0C0C;
            8'h7D : font_char = 64'h000E18183818180E;
            8'h7E : font_char = 64'h000000006E6B3B00;
            8'hA1 : font_char = 64'h000C000C1E1E1E0C;
            8'hA2 : font_char = 64'h00083E6B0B6B3E08;
            8'hA3 : font_char = 64'h003C66461F06067F;
            8'hA4 : font_char = 64'h0000221C141C2200;
            8'hA5 : font_char = 64'h0063361C3E083E08;
            8'hA6 : font_char = 64'h000C0C0C000C0C0C;
            8'hA7 : font_char = 64'h001E033F637E603C;
            8'hA8 : font_char = 64'h0036000000000000;
            8'hA9 : font_char = 64'h003E415D455D413E;
            8'hAA : font_char = 64'h003E607E637E0000;
            8'hAB : font_char = 64'h0000006C361B366C;
            8'hAC : font_char = 64'h000000003E303000;
            8'hAD : font_char = 64'h00000000003E0000;
            8'hAE : font_char = 64'h003E41554D45413E;
            8'hAF : font_char = 64'h003E000000000000;
            8'hB0 : font_char = 64'h003E7363673E0000;
            8'hB1 : font_char = 64'h0008083E0808003E;
            8'hB2 : font_char = 64'h003E63380C7E0000;
            8'hB3 : font_char = 64'h003E6338633E0000;
            8'hB4 : font_char = 64'h0010080000000000;
            8'hB5 : font_char = 64'h00636363633F0303;
            8'hB6 : font_char = 64'h007C2E2F2E2C2828;
            8'hB7 : font_char = 64'h0000000008000000;
            8'hB8 : font_char = 64'h0000000000000804;
            8'hB9 : font_char = 64'h001E1818187E0000;
            8'hBA : font_char = 64'h003E6363633E0000;
            8'hBB : font_char = 64'h0000001B366C361B;
            8'hBC : font_char = 64'h0002035252774040;
            8'hBD : font_char = 64'h0002033242271070;
            8'hBE : font_char = 64'h0003045254734040;
            8'hBF : font_char = 64'h001800181E03633E;
            8'hC0 : font_char = 64'h0004081C36637F63;
            8'hC1 : font_char = 64'h0010081C36637F63;
            8'hC2 : font_char = 64'h0008141C36637F63;
            8'hC3 : font_char = 64'h0028141C36637F63;
            8'hC4 : font_char = 64'h0036001C36637F63;
            8'hC5 : font_char = 64'h001C141C36637F63;
            8'hC6 : font_char = 64'h007C1E1B7B1F1B7B;
            8'hC7 : font_char = 64'h003E6303633E0804;
            8'hC8 : font_char = 64'h0004087F031F037F;
            8'hC9 : font_char = 64'h0010087F031F037F;
            8'hCA : font_char = 64'h0008147F031F037F;
            8'hCB : font_char = 64'h0036007F031F037F;
            8'hCC : font_char = 64'h0004087F1C1C1C7F;
            8'hCD : font_char = 64'h0010087F1C1C1C7F;
            8'hCE : font_char = 64'h0008147F1C1C1C7F;
            8'hCF : font_char = 64'h0036007F1C1C1C7F;
            8'hD0 : font_char = 64'h001E36666F66361E;
            8'hD1 : font_char = 64'h00281463676B7363;
            8'hD2 : font_char = 64'h0004083E6363633E;
            8'hD3 : font_char = 64'h0010083E6363633E;
            8'hD4 : font_char = 64'h0008143E6363633E;
            8'hD5 : font_char = 64'h0028143E6363633E;
            8'hD6 : font_char = 64'h0036003E6363633E;
            8'hD7 : font_char = 64'h0000002214081422;
            8'hD8 : font_char = 64'h003E63736B67633E;
            8'hD9 : font_char = 64'h000408636363633E;
            8'hDA : font_char = 64'h001008636363633E;
            8'hDB : font_char = 64'h000814636363633E;
            8'hDC : font_char = 64'h003600636363633E;
            8'hDD : font_char = 64'h00100863633E1C1C;
            8'hDE : font_char = 64'h00033F6363633F03;
            8'hDF : font_char = 64'h001E331B3B636B3B;
            8'hE0 : font_char = 64'h0004083E607E637E;
            8'hE1 : font_char = 64'h0010083E607E637E;
            8'hE2 : font_char = 64'h0008143E607E637E;
            8'hE3 : font_char = 64'h0028143E607E637E;
            8'hE4 : font_char = 64'h0036003E607E637E;
            8'hE5 : font_char = 64'h001C143E607E637E;
            8'hE6 : font_char = 64'h0000003F6C7F0D3F;
            8'hE7 : font_char = 64'h00007E03037E0804;
            8'hE8 : font_char = 64'h0004083E637F033E;
            8'hE9 : font_char = 64'h0010083E637F033E;
            8'hEA : font_char = 64'h0008143E637F033E;
            8'hEB : font_char = 64'h0036003E637F033E;
            8'hEC : font_char = 64'h0004081E1818187F;
            8'hED : font_char = 64'h0010081E1818187F;
            8'hEE : font_char = 64'h0008141E1818187F;
            8'hEF : font_char = 64'h0036001E1818187F;
            8'hF0 : font_char = 64'h0018307E6363633E;
            8'hF1 : font_char = 64'h0028143F63636363;
            8'hF2 : font_char = 64'h000408003E63633E;
            8'hF3 : font_char = 64'h001008003E63633E;
            8'hF4 : font_char = 64'h000814003E63633E;
            8'hF5 : font_char = 64'h002814003E63633E;
            8'hF6 : font_char = 64'h000036003E63633E;
            8'hF7 : font_char = 64'h00000008003E0008;
            8'hF8 : font_char = 64'h0000003E736B673E;
            8'hF9 : font_char = 64'h000408006363633E;
            8'hFA : font_char = 64'h001008006363633E;
            8'hFB : font_char = 64'h000814006363633E;
            8'hFC : font_char = 64'h000036006363633E;
            8'hFD : font_char = 64'h0010086363361C0F;
            8'hFE : font_char = 64'h0003033F633F0303;
            8'hFF : font_char = 64'h0036006363361C0F;
            default : font_char = 64'h0;
        endcase

endmodule
