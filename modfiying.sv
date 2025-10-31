`timescale 1ns/1ps

module test_bench_new;
    bit clk;
    bit start = 1'b1;
    wire done;

    logic [4:0] Dist, Min, Max;
    logic [4:0] Min1, Min2;
    logic [4:0] Max1, Max2;
    logic [15:0] Tmp[32];

    Top D1 (
        .clk(clk),
        .start(start),
        .done(done)
    );

    always begin
        #50 clk = 1'b1;
        #50 clk = 1'b0;
    end

    int itrs = 10;
    int min_pass = 0;
    int max_pass = 0;

    initial begin
        for(int loop_ct = 0; loop_ct < itrs; loop_ct++) begin
            #100;
            Min = 'd16;
            Max = 'd0;
            case(loop_ct)
                0: $readmemb("test0.txt", D1.DM1.core);
                1: $readmemb("test1.txt", D1.DM1.core);
                2: $readmemb("test2.txt", D1.DM1.core);
                3: $readmemb("test3.txt", D1.DM1.core);
                4: $readmemb("test4.txt", D1.DM1.core);
                5: $readmemb("test5.txt", D1.DM1.core);
                6: $readmemb("test6.txt", D1.DM1.core);
                7: $readmemb("test7.txt", D1.DM1.core);
                8: $readmemb("test8.txt", D1.DM1.core);
                9: $readmemb("test9.txt", D1.DM1.core);
            endcase
            for(int i = 0; i < 32; i++) begin
                Tmp[i] = {D1.DM1.core[2*i], D1.DM1.core[2*i+1]};
                $display("%d:  %b", i, Tmp[i]);
            end
            D1.DM1.core[64] = 'd16;
            for(int r = 65; r < 256; r++)
                D1.DM1.core[r] = 'd0;

            for(int j = 0; j < 32; j++) begin
                for(int k = j + 1; k < 32; k++) begin
                    #1 Dist = ham(Tmp[j], Tmp[k]);
                    if(Dist < Min) begin
                        Min = Dist;
                        Min2 = j;
                        Min1 = k;
                    end  
                    if(Dist > Max) begin
                        Max = Dist;
                        Max2 = j;
                        Max1 = k;
                    end
                end
            end
            #200 start = 1'b0;
            #200 wait (done);

            if(Min == D1.DM1.core[64]) begin
                $display("good Min = %d", Min);
                min_pass++;
            end else begin
                $display("fail Min: Correct = %d; Yours = %d", Min, D1.DM1.core[64]);
                $display("Min addr = %d, %d", Min1, Min2);
                $display("Min valu = %b, %b", Tmp[Min1], Tmp[Min2]);
            end
            if(Max == D1.DM1.core[65]) begin
                $display("good Max = %d", Max);
                max_pass++;
            end else begin
                $display("fail Max: Correct = %d; Yours = %d", Max, D1.DM1.core[65]);
                $display("Max pair = %d, %d", Max1, Max2);
                $display("Max valu = %b, %b", Tmp[Max1], Tmp[Max2]);
            end
            #200 start = 1'b1;
            if(loop_ct == itrs - 1) begin
                $display("Minimum correct %d/%d", min_pass, itrs);
                $display("Maximum correct %d/%d", max_pass, itrs);
                $stop;
            end
            #200 start = 1'b0;
        end
    end

    function [4:0] ham(input [15:0] a, b);
        ham = 'b0;
        for(int q = 0; q < 16; q++)
            if(a[q] ^ b[q])
                ham++;
    endfunction
endmodule
