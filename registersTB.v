module TBRegisters();
reg clk_sig, reset, load;
reg[3:0] addr;
reg[7:0] data_in;
wire[7:0] data_out;
integer stage;

	initial begin
		clk_sig = 0;
		stage = 0;
	end
register_unit registerUnit (reset, clk_sig, load, addr, data_out, data_in);
// module register_unit (reset, clock, load, addr, data_out, data_in);
	always
		begin
			#25 clk_sig = !clk_sig;

			if (clk_sig == 1) begin
				stage = stage +1;

				case (stage)
					1: begin // Simulate resetting all internal register slots to 0
						reset = 1;
					end
					2: begin // store 4 into register slot 1
						reset = 0;
						addr = 4'b0001;
						load = 1;
						data_in = 8'b00000100; // 4
					end
					3: begin // store 5 into register slot 2
						reset = 0;
						addr = 4'b0010;
						load = 1;
						data_in = 8'b00000101; // 5
					end
					4: begin // Read register value from slot 1 -> which should be 4 -> showing in data out
						reset = 0;
						addr = 4'b0001;
						load = 0;
						data_in = 8'b0000000; // 0
					end
					5: begin // Read register value from slot 2 -> which should be 5 -> showing in data out
						reset = 0;
						addr = 4'b0010;
						load = 0;
						data_in = 8'b00000000; // 0
					end
					6: begin // Read register value from slot 3 -> which should be 0 -> showing in data out
						reset = 0;
						addr = 4'b0011;
						load = 0;
						data_in = 8'b00000000; // 0
					end
					7: begin // Read register value from slot 1 -> which should be 4 -> showing in data out
						reset = 0;
						addr = 4'b0010;
						load = 0;
						data_in = 8'b00000000; // 0
					end
					8: begin
						stage = 0; // Start back at the beginning of the state machine
					end
					default: reset = 0;
				endcase 
			end
		end
endmodule
