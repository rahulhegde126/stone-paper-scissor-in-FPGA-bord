# Hardware Stone-Paper-Scissors (SystemVerilog)

A digital hardware logic implementation of the classic "Stone, Paper, Scissors" game written in **SystemVerilog**. 

This RTL module evaluates the choices of two players synchronously and outputs the match result directly to a set of LEDs. It is designed to be implemented on an FPGA or simulated within a testbench environment.

## How It Works

The core logic operates on a synchronous clock edge and uses a combination of switches and buttons for gameplay:

1. **Input Selection:** Players lock in their choices using 2-bit inputs (`player1` and `player2`), typically mapped to hardware toggle switches.
2. **Evaluation (`btn_play`):** When the play button is asserted high, the module evaluates the 4-bit concatenated choices of both players during the next clock cycle.
3. **Result Calculation:** A synthesized combinational logic block (implemented via a `case` statement) determines the winner based on standard game rules.
4. **Display:** The internal `game_result_t` state is mapped to a 3-bit one-hot LED output to indicate the outcome (Player 1 Win, Player 2 Win, or Draw).

---

## Data Encoding

### Player Inputs (`player1` / `player2`)
| Binary Value | Choice   |
| :---         | :---     |
| `2'b00`      | Stone    |
| `2'b01`      | Paper    |
| `2'b10`      | Scissors |

### Result Output (`leds`)
| Binary Value | Outcome              |
| :---         | :---                 |
| `3'b001`     | Player 1 Wins (LED 0)|
| `3'b010`     | Player 2 Wins (LED 1)|
| `3'b100`     | Draw (LED 2)         |

---

## Module I/O Ports

| Signal Name | Direction | Width | Description |
| :---        | :---      | :---  | :--- |
| `clk`       | Input     | 1-bit | System clock |
| `reset`     | Input     | 1-bit | Active-high synchronous reset; clears LEDs and sets state to DRAW |
| `player1`   | Input     | 2-bit | Player 1's encoded choice |
| `player2`   | Input     | 2-bit | Player 2's encoded choice |
| `btn_play`  | Input     | 1-bit | Button to evaluate the inputs and update the LEDs |
| `leds`      | Output    | 3-bit | One-hot encoded output displaying the game result |

---

## Integration / Instantiation Template

```systemverilog
// Example instantiation for a top-module
stone u_stone_game (
    .clk      (sys_clk),
    .reset    (sys_rst),
    .player1  (sw_p1[1:0]),
    .player2  (sw_p2[1:0]),
    .btn_play (btn_eval),
    .leds     (led_result[2:0])
);
