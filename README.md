# Vending Machine Controller

A simple Verilog implementation of a vending machine controller that dispenses chocolate and drinks.

## Overview

This vending machine accepts coins and dispenses two types of products:
- **Chocolate**: Costs $15
- **Drink**: Costs $10

The machine accepts $5 and $10 coins and provides change when necessary.

## Features

- **Two Product Options**: Choose between chocolate ($15) or drink ($10)
- **Coin Input**: Accepts $5 and $10 denominations
- **Change System**: Automatically calculates and dispenses change
- **State Management**: Uses a 3-state finite state machine
- **Reset Functionality**: Can be reset to initial state

## How It Works

The machine operates using a finite state machine with three states:
- **State 0**: No money inserted (initial state)
- **State 1**: $5 inserted
- **State 2**: $10 inserted

### Product Selection
- Set `select_products` to 0 for chocolate
- Set `select_products` to 1 for drink

### Coin Input
- `coin = 00`: No coin inserted
- `coin = 01`: $5 coin inserted
- `coin = 10`: $10 coin inserted

### Outputs
- `out`: Goes high when product is dispensed
- `change`: Amount of change returned (in $1 units)

## Usage Examples

**Buying Chocolate ($15):**
- Insert $5 coin → Insert $10 coin → Product dispensed
- Insert $10 coin → Insert $5 coin → Product dispensed
- Insert $10 coin → Insert $10 coin → Product dispensed + $5 change

**Buying Drink ($10):**
- Insert $10 coin → Product dispensed immediately
- Insert $5 coin → Insert $5 coin → Product dispensed
- Insert $5 coin → Insert $10 coin → Product dispensed + $5 change

## Signal Descriptions

| Signal | Direction | Description |
|--------|-----------|-------------|
| clk | Input | Clock signal |
| reset | Input | Reset the machine to initial state |
| select_products | Input | Product selection (0=chocolate, 1=drink) |
| coin | Input | Coin denomination input |
| out | Output | Product dispensed indicator |
| change | Output | Change amount in dollars |

## Reset Behavior

When reset is asserted, the machine:
- Returns to initial state (State 0)
- Clears all outputs
- Resets change to $0

## Notes

- The machine uses synchronous design with positive edge-triggered clock
- All state transitions occur on clock edges
- Change is calculated and dispensed automatically
- The machine handles exact payment and overpayment scenarios
