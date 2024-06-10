module DUT (
    input clk,
    input start,
    output reg done
);
    // Define states for the state machine
    typedef enum reg [1:0] {
        IDLE,
        COMPUTE,
        STORE,
        FINISH
    } state_t;

    state_t state, next_state;

    reg [4:0] i, j;
    reg [4:0] min_distance, max_distance;
    reg [4:0] hamming_distance;

    reg [15:0] array [0:31];
    reg [15:0] tmp1, tmp2;
    reg [7:0] memory [0:255];  // Memory to store data and results

    // Calculate Hamming distance
    function [4:0] calculate_hamming_distance;
        input [15:0] a, b;
        integer k;
        begin
            calculate_hamming_distance = 5'b0;
            for (k = 0; k < 16; k = k + 1) begin
                if (a[k] != b[k])
                    calculate_hamming_distance = calculate_hamming_distance + 1;
            end
        end
    endfunction

    // Load data into array from memory
    integer k;
    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            array[k] = {memory[2*k], memory[2*k+1]};
        end
    end

    // State machine
    always @(posedge clk) begin
        if (start) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                min_distance = 5'b11111; // MAX_VALUE
                max_distance = 5'b0;
                i = 5'b0;
                j = 5'b1;
                next_state = COMPUTE;
            end
            COMPUTE: begin
                if (i < 31) begin
                    if (j <= 31) begin
                        tmp1 = array[i];
                        tmp2 = array[j];
                        hamming_distance = calculate_hamming_distance(tmp1, tmp2);
                        if (hamming_distance < min_distance)
                            min_distance = hamming_distance;
                        if (hamming_distance > max_distance)
                            max_distance = hamming_distance;
                        j = j + 1;
                    end else begin
                        i = i + 1;
                        j = i + 1;
                    end
                    next_state = COMPUTE;
                end else begin
                    next_state = STORE;
                end
            end
            STORE: begin
                memory[64] = min_distance;
                memory[65] = max_distance;
                next_state = FINISH;
            end
            FINISH: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
