####################### Design Programe ####################################3
module stone (
    input logic clk,              // Clock input
    input logic reset,            // Reset signal
    input logic [1:0] player1,    // Player 1's choice (00 = Stone, 01 = Paper, 10 = Scissors)
    input logic [1:0] player2,    // Player 2's choice (00 = Stone, 01 = Paper, 10 = Scissors)
    input logic btn_play,         // Button to start the game
    output logic [2:0] leds       // LEDs to display the result
);

    // States for result
    typedef enum logic [1:0] {
        PLAYER1_WIN = 2'b01,
        PLAYER2_WIN = 2'b10,
        DRAW        = 2'b00
    } game_result_t;

    game_result_t result;         // Internal register to store the result

    // Game logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= DRAW;       // Reset result to DRAW
            leds <= 3'b000;       // Turn off all LEDs
        end else if (btn_play) begin
            // Determine the winner based on choices
            case ({player1, player2})
                4'b0000, 4'b0101, 4'b1010: result <= DRAW;        // Both players choose the same
                4'b0001, 4'b0110, 4'b1000: result <= PLAYER2_WIN; // Player 2 wins
                4'b0010, 4'b0100, 4'b1011: result <= PLAYER1_WIN; // Player 1 wins
                default: result <= DRAW;                         // Default case (safety)
            endcase

            // Update LEDs based on the result
            case (result)
                PLAYER1_WIN: leds <= 3'b001; // LED 0 ON
                PLAYER2_WIN: leds <= 3'b010; // LED 1 ON
                DRAW:        leds <= 3'b100; // LED 2 ON
            endcase
        end
    end

endmodule

