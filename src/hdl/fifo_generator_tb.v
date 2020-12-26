//
// Copyright 2020 Developed by Reza Molaei
//
// SPDX-License-Identifier: LGPL-3.0-or-later
//

`timescale 1ns / 1ps
module fifo_generator_tb #(
   parameter clk_freq = 4000000          // Hz
);

//###############################################################################################
//###                              clock and reset                                            ###
//###############################################################################################
   localparam [31:0] clk_period=1000000000.0/$itor(clk_freq);
   reg wr_clk = 1'b0;
   reg rd_clk = 1'b0;
   wire rst;

   always @(*) begin
     #(clk_period/2);
     wr_clk <= ~wr_clk;
   end
   
   always @(*) begin
     #(clk_period/4);
     rd_clk <= wr_clk;
   end

   por_gen por_gen (
      .clk(wr_clk),
      .reset_out(rst)
   );
//###############################################################################################
//###                              END clock and reset                                        ###
//###############################################################################################

//###############################################################################################
//###                              write and read processes                                   ###
//###############################################################################################
   reg [7 : 0] din;
   reg wr_en = 1'b0;
   reg rd_en = 1'b0;
   always @(*) begin
      #(clk_period*13);
      if(~rst) begin
         #(clk_period*17);
         //
         din <= 8'hFF;  wr_en <= 1'b1;                 #clk_period;
                        wr_en <= 1'b0;                 #(clk_period*10);

         din <= 8'hFE;  wr_en <= 1'b1;                 #clk_period;
                        wr_en <= 1'b0;                 #(clk_period*10);

         din <= 8'hFD;  wr_en <= 1'b1;                 #clk_period;
                        wr_en <= 1'b0;                 #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b0;  #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b0;  #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b0;  #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b0;  #(clk_period*10);

         din <= 8'hFF;  wr_en <= 1'b1;                 #clk_period;
                        wr_en <= 1'b0;                 #clk_period;

         din <= 8'hFE;  wr_en <= 1'b1;                 #clk_period;
         din <= 8'hFD;                                 #clk_period;
         din <= 8'hFC;                                 #clk_period;
         din <= 8'hFB;                                 #clk_period;
         din <= 8'hFA;                                 #clk_period;
         din <= 8'hF9;                                 #clk_period;
         din <= 8'hF8;                                 #clk_period;
         din <= 8'hF7;                                 #clk_period;
         din <= 8'hF6;                                 #clk_period;
         din <= 8'hF5;                                 #clk_period;
         din <= 8'hF4;                                 #clk_period;
         din <= 8'hF3;                                 #clk_period;
         din <= 8'hF2;                                 #clk_period;
         din <= 8'hF1;                                 #clk_period;
         din <= 8'hF0;                                 #clk_period;
         din <= 8'h0F;                                 #clk_period;
         din <= 8'h0E;                                 #clk_period;
         din <= 8'h0D;                                 #clk_period;
         din <= 8'h0C;                                 #clk_period;

                        wr_en <= 1'b0;                 #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b0;  #(clk_period*10);

                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;
                                       rd_en <= 1'b1;  #clk_period;

                                       rd_en <= 1'b0;  #(clk_period*10);
         #(clk_period*110);
         //
      end
   end
//###############################################################################################
//###                              END write and read processes                               ###
//###############################################################################################

//###############################################################################################
//###                              fifo_generator_fifo0 instantution                          ###
//###############################################################################################
   wire [7 : 0] dout_fifo0;
   wire full_fifo0, almost_full_fifo0, wr_ack_fifo0, overflow_fifo0, empty_fifo0, almost_empty_fifo0, valid_fifo0, underflow_fifo0;
   wire [3 : 0] rd_data_count_fifo0;
   wire [3 : 0] wr_data_count_fifo0;
   fifo_generator_fifo0 fifo_generator_fifo0 (
      .rst           (rst),                 // input wire rst
      .wr_clk        (wr_clk),              // input wire wr_clk
      .rd_clk        (rd_clk),              // input wire rd_clk
      .din           (din),                 // input wire [7 : 0] din
      .wr_en         (wr_en),               // input wire wr_en
      .rd_en         (rd_en),               // input wire rd_en
      .dout          (dout_fifo0),          // output wire [7 : 0] dout
      .full          (full_fifo0),          // output wire full
      .almost_full   (almost_full_fifo0),   // output wire almost_full
      .wr_ack        (wr_ack_fifo0),        // output wire wr_ack
      .overflow      (overflow_fifo0),      // output wire overflow
      .empty         (empty_fifo0),         // output wire empty
      .almost_empty  (almost_empty_fifo0),  // output wire almost_empty
      .valid         (valid_fifo0),         // output wire valid
      .underflow     (underflow_fifo0),     // output wire underflow
      .rd_data_count (rd_data_count_fifo0), // output wire [3 : 0] rd_data_count
      .wr_data_count (wr_data_count_fifo0)  // output wire [3 : 0] wr_data_count
   );
//###############################################################################################
//###                              END fifo_generator_fifo0 instantution                      ###
//###############################################################################################

//###############################################################################################
//###                              fifo_generator_fifo1 instantution                          ###
//###############################################################################################
   wire [7 : 0] dout_fifo1;
   wire full_fifo1, almost_full_fifo1, wr_ack_fifo1, overflow_fifo1, empty_fifo1, almost_empty_fifo1, valid_fifo1, underflow_fifo1;
   wire [3 : 0] rd_data_count_fifo1;
   wire [3 : 0] wr_data_count_fifo1;
   fifo_generator_fifo1 fifo_generator_fifo1 (
      .rst           (rst),                 // input wire rst
      .wr_clk        (wr_clk),              // input wire wr_clk
      .rd_clk        (rd_clk),              // input wire rd_clk
      .din           (din),                 // input wire [7 : 0] din
      .wr_en         (wr_en),               // input wire wr_en
      .rd_en         (rd_en),               // input wire rd_en
      .dout          (dout_fifo1),          // output wire [7 : 0] dout
      .full          (full_fifo1),          // output wire full
      .almost_full   (almost_full_fifo1),   // output wire almost_full
      .wr_ack        (wr_ack_fifo1),        // output wire wr_ack
      .overflow      (overflow_fifo1),      // output wire overflow
      .empty         (empty_fifo1),         // output wire empty
      .almost_empty  (almost_empty_fifo1),  // output wire almost_empty
      .valid         (valid_fifo1),         // output wire valid
      .underflow     (underflow_fifo1),     // output wire underflow
      .rd_data_count (rd_data_count_fifo1), // output wire [3 : 0] rd_data_count
      .wr_data_count (wr_data_count_fifo1)  // output wire [3 : 0] wr_data_count
   );
//###############################################################################################
//###                              END fifo_generator_fifo1 instantution                      ###
//###############################################################################################

//###############################################################################################
//###                              fifo_generator_fwft0 instantution                          ###
//###############################################################################################
   wire [7 : 0] dout_fwft0;
   wire full_fwft0, almost_full_fwft0, wr_ack_fwft0, overflow_fwft0, empty_fwft0, almost_empty_fwft0, valid_fwft0, underflow_fwft0;
   wire [4 : 0] rd_data_count_fwft0;
   wire [4 : 0] wr_data_count_fwft0;
   fifo_generator_fwft0 fifo_generator_fwft0 (
      .rst           (rst),                 // input wire rst
      .wr_clk        (wr_clk),              // input wire wr_clk
      .rd_clk        (rd_clk),              // input wire rd_clk
      .din           (din),                 // input wire [7 : 0] din
      .wr_en         (wr_en),               // input wire wr_en
      .rd_en         (rd_en),               // input wire rd_en
      .dout          (dout_fwft0),          // output wire [7 : 0] dout
      .full          (full_fwft0),          // output wire full
      .almost_full   (almost_full_fwft0),   // output wire almost_full
      .wr_ack        (wr_ack_fwft0),        // output wire wr_ack
      .overflow      (overflow_fwft0),      // output wire overflow
      .empty         (empty_fwft0),         // output wire empty
      .almost_empty  (almost_empty_fwft0),  // output wire almost_empty
      .valid         (valid_fwft0),         // output wire valid
      .underflow     (underflow_fwft0),     // output wire underflow
      .rd_data_count (rd_data_count_fwft0), // output wire [4 : 0] rd_data_count
      .wr_data_count (wr_data_count_fwft0)  // output wire [4 : 0] wr_data_count
   );
//###############################################################################################
//###                              END fifo_generator_fwft0 instantution                      ###
//###############################################################################################

//###############################################################################################
//###                              fifo_generator_fwft1 instantution                          ###
//###############################################################################################
   wire [7 : 0] dout_fwft1;
   wire full_fwft1, almost_full_fwft1, wr_ack_fwft1, overflow_fwft1, empty_fwft1, almost_empty_fwft1, valid_fwft1, underflow_fwft1;
   wire [4 : 0] rd_data_count_fwft1;
   wire [4 : 0] wr_data_count_fwft1;
   fifo_generator_fwft1 fifo_generator_fwft1 (
      .rst           (rst),                 // input wire rst
      .wr_clk        (wr_clk),              // input wire wr_clk
      .rd_clk        (rd_clk),              // input wire rd_clk
      .din           (din),                 // input wire [7 : 0] din
      .wr_en         (wr_en),               // input wire wr_en
      .rd_en         (rd_en),               // input wire rd_en
      .dout          (dout_fwft1),          // output wire [7 : 0] dout
      .full          (full_fwft1),          // output wire full
      .almost_full   (almost_full_fwft1),   // output wire almost_full
      .wr_ack        (wr_ack_fwft1),        // output wire wr_ack
      .overflow      (overflow_fwft1),      // output wire overflow
      .empty         (empty_fwft1),         // output wire empty
      .almost_empty  (almost_empty_fwft1),  // output wire almost_empty
      .valid         (valid_fwft1),         // output wire valid
      .underflow     (underflow_fwft1),     // output wire underflow
      .rd_data_count (rd_data_count_fwft1), // output wire [4 : 0] rd_data_count
      .wr_data_count (wr_data_count_fwft1)  // output wire [4 : 0] wr_data_count
   );
//###############################################################################################
//###                              END fifo_generator_fwft1 instantution                      ###
//###############################################################################################

endmodule
