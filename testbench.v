module stone_tb;

    // Inputs
    logic clk;
    logic reset;
    logic [1:0] player1;
    logic [1:0] player2;
    logic btn_play;

    // Outputs
    logic [2:0] leds;

    // Instantiate DUT
    stone dut (
        .clk(clk),
        .reset(reset),
        .player1(player1),
        .player2(player2),
        .btn_play(btn_play),
        .leds(leds)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Testbench Logic
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        player1 = 2'b00;  // Stone
        player2 = 2'b00;  // Stone
        btn_play = 0;

        // Apply Reset
        #10 reset = 0;

        // Test 1: Draw (Stone vs Stone)
        #10 player1 = 2'b00; player2 = 2'b00; btn_play = 1;
        #10 btn_play = 0;
        #10 $display("Test 1 - Draw: LEDs = %b", leds);

        // Test 2: Player 1 wins (Stone vs Scissors)
        #10 player1 = 2'b00; player2 = 2'b10; btn_play = 1;
        #10 btn_play = 0;
        #10 $display("Test 2 - Player 1 Wins: LEDs = %b", leds);

        // Test 3: Player 2 wins (Paper vs Stone)
        #10 player1 = 2'b00; player2 = 2'b01; btn_play = 1;
        #10 btn_play = 0;
        #10 $display("Test 3 - Player 2 Wins: LEDs = %b", leds);

        // Test 4: Draw (Scissors vs Scissors)
        #10 player1 = 2'b10; player2 = 2'b10; btn_play = 1;
        #10 btn_play = 0;
        #10 $display("Test 4 - Draw: LEDs = %b", leds);

        // Test 5: Player 2 wins (Scissors vs Rock)
        #10 player1 = 2'b10; player2 = 2'b00; btn_play = 1;
        #10 btn_play = 0;
        #10 $display("Test 5 - Player 2 Wins: LEDs = %b", leds);

        // End simulation
        #20 $finish;
    end
