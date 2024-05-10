`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 14:14:32
// Design Name: 
// Module Name: write_stratge_tb
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


module write_stratge_tb();


reg                 sys_clk;
reg                 rst_n;
reg                 woble_clk;
// reg                 woble_clk_ps;           //woble_clk 延时4.4ns
wire                woble_clk_ps;           //woble_clk 延时4.4ns
wire                woble_clk_ps_0;           //woble_clk 延时4.4ns
reg                 mem_clk;
reg                 start_en;               //1:write 2765 
reg                 dlc_s0_dly;             
reg                 dlc_s1_dly;          
wire                psen_0                ;
wire                psincdec_0            ;
wire                psdone_0              ; 
wire                psen_1                ;
wire                psincdec_1            ;
wire                psdone_1              ; 
reg                 wr_stt_test_data_flag;    
reg     [31: 0]     wr_stt_test_data;
reg                 wr_stt_pw_data_flag;
reg     [3 : 0]		wr_stt_pw_data;             //写策略功率数据 bit3-2:outen3,bit1-0:outen2
reg                 woble_clk_ps_data_flag;
reg     [13: 0]     woble_clk_ps_data   ;       //woble clk ps data bit13:psincdec,bit12:ps_cnt_0,bit11-0:ps_cnt_1 

wire    [7 : 0]     test_str;
assign              test_str = "8";


initial begin       
        woble_clk_ps_data_flag          <=  1'b0;
        woble_clk_ps_data               <=  14'd0;
        # (100 + 1000)
        woble_clk_ps_data_flag          <=  1'b1;
        woble_clk_ps_data               <=  {1'b1,1'b0,12'd600};
        # 5
        woble_clk_ps_data_flag          <=  1'b0;
end 




initial begin       
        sys_clk         <=  1'b0;
        rst_n           <=  1'b0;
        woble_clk       <=  1'b0;
        mem_clk         <=  1'b0;
        dlc_s0_dly      <=  1'b0;
        dlc_s1_dly      <=  1'b0;


        start_en        <=  1'b0;
        # 100 
        rst_n           <= 1'b1;
        
        
        #1000 
        //bit26:invert_sel,bit25-15:d1,bit14-4:d0,bit3:sg1,bit2:sg0,bit1:ps_sel,bit0:dlc_sel
        wr_stt_test_data_flag   <= 1'b1;      
        
        repeat (2) begin 
            wr_stt_test_data        <= {2'b00,4'h0,11'h000,11'h726,1'b0,1'b1,1'b0,1'b0}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h726,1'b1,1'b0,1'b0,1'b0}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h726,1'b0,1'b1,1'b0,1'b1}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h726,1'b1,1'b0,1'b1,1'b0}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h5A3,1'b0,1'b1,1'b0,1'b1}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h5A3,1'b1,1'b0,1'b1,1'b0}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h0,11'h726,11'h5A3,1'b0,1'b0,1'b1,1'b1}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h0,11'h000,11'h000,1'b0,1'b0,1'b0,1'b0}; 
            # 5      
    
            wr_stt_test_data        <= {2'b00,4'h1,11'h000,11'h726,1'b0,1'b1,1'b0,1'b0}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h726,1'b1,1'b0,1'b0,1'b0}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h726,1'b0,1'b1,1'b0,1'b1}; 
            # 5    
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h726,1'b1,1'b0,1'b1,1'b0}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h5A3,1'b0,1'b1,1'b0,1'b1}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h5A3,1'b1,1'b0,1'b1,1'b0}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h1,11'h726,11'h5A3,1'b0,1'b0,1'b1,1'b1}; 
            # 5      
            wr_stt_test_data        <= {2'b00,4'h1,11'h000,11'h000,1'b0,1'b0,1'b0,1'b0}; 
            # 5  
            ;    
        end 

        wr_stt_test_data_flag   <= 1'b0;  



        # (40000-80)
        start_en        <=  1'b1; 
        # 40000
        start_en        <=  1'b0; 

        
        # 2000
        start_en        <=  1'b1; 
        # 40000
        start_en        <=  1'b0; 
end

initial begin       
        # (41247.875 + 15.15*2 )
        repeat (4) begin 
            # 7.575 
            dlc_s0_dly      <=  1'b1;
            # 15.15
            dlc_s0_dly      <=  1'b0;
            # 15.15
            dlc_s0_dly      <=  1'b1;
            # 15.15
            dlc_s0_dly      <=  1'b0;
            # (15.15-(3.78))  //
            dlc_s0_dly      <=  1'b1;
            # 15.15
            dlc_s0_dly      <=  1'b0;
            # 15.15
            dlc_s0_dly      <=  1'b0;
            # 15.15
            dlc_s0_dly      <=  1'b0;

            # ( 7.57 + 3.78 + 15.15*9 )
            ;

        end 
end

initial begin       
        # (41247.875 + 15.15*2 -5)
        repeat (4) begin 
            # ( 7.575 + 15.15 )
            dlc_s1_dly      <=  1'b1;
            # 15.15
            dlc_s1_dly      <=  1'b0;
            # 15.15
            dlc_s1_dly      <=  1'b1;
            # 15.15
            dlc_s1_dly      <=  1'b0;
            # 15.15
            dlc_s1_dly      <=  1'b1;
            # 15.15
            dlc_s1_dly      <=  1'b0;


            # ( 7.575 + 15.15 + 15.15*9 )
            ;
        end 
end 


initial begin       
        # (10000)
        repeat (4) begin 
            wr_stt_pw_data_flag     <= 1'b1;
            wr_stt_pw_data          <= { 1'b1,1'b0,1'b0,1'b0 };
            # 5
            wr_stt_pw_data          <= { 1'b1,1'b1,1'b0,1'b0 };
            # 5
            wr_stt_pw_data          <= { 1'b0,1'b0,1'b0,1'b0 };
            # 5
            wr_stt_pw_data          <= { 1'b1,1'b0,1'b0,1'b0 };
            # 5
            wr_stt_pw_data          <= { 1'b0,1'b1,1'b0,1'b0 };
            # 5
            wr_stt_pw_data_flag     <= 1'b0;
        end 


end 

// initial begin       
//         # (4.4)
//         woble_clk_ps       <=  1'b0;
        
//         repeat (100000) begin 
//         #(2.5)    
//         woble_clk_ps       <=  ~woble_clk_ps;

//         end 

 
// end

always #(2.5)   sys_clk = ~sys_clk;
always #(7.575)   woble_clk = ~woble_clk;
always #(2.5)   mem_clk = ~mem_clk;



cxa2765_write_stratge write_stratge_inst(
.sys_clk        ( sys_clk           ),
.WOBLE_CLK_IN   ( woble_clk         ),
.mem_clk        ( mem_clk           ),
.rst_n          ( rst_n             ),

.woble_clk_ps_data_flag	( woble_clk_ps_data_flag    ),
.woble_clk_ps_data 	  	( woble_clk_ps_data 	    ),
.woble_clk_ps   ( woble_clk_ps      ),       //woble_clk 延时4.4ns             
.psen         ( psen_0                    ),
.psincdec     ( psincdec_0                ),
.psdone       ( psdone_0                  ), 

.wr_stt_test_data_flag(wr_stt_test_data_flag),   
.wr_stt_test_data(wr_stt_test_data),
.wr_stt_pw_data_flag(wr_stt_pw_data_flag),   
.wr_stt_pw_data(wr_stt_pw_data),

.DLC_CLK_OUT_P  ( {dlc_s1_dly,dlc_s0_dly} ),       //delay chip1 chip0 clk out                    
.DLC_CLK_OUT_N  ( {~dlc_s1_dly,~dlc_s0_dly} ),       //delay chip1 chip0 clk out 

.start_en       ( start_en        )           //1:write 2765 
);


woble_clk_tb   woble_clk_ps_inst0(    
  // Clock in ports
  // Clock out ports
  .clk_out1         ( woble_clk_ps  ),
  // Dynamic phase shift ports
  .psclk            ( sys_clk       ),
  .psen             ( psen_0          ),
  .psincdec         ( psincdec_0      ),
  .psdone           ( psdone_0        ),
  // Status and control signals
  .resetn           ( rst_n         ),
  .clk_in1          ( woble_clk     )
 );






endmodule
