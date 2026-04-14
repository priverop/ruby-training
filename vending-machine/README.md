# Vending Machine

Implement a simple vending machine in Ruby.

## Requirements

### Inventory
The vending machine holds a set of products. Each product has:
- A **name** (or code)
- A **price** (in cents)
- A **quantity** available

### Coins
The machine accepts coins of the following denominations (in cents):
`5, 10, 20, 50, 100, 200`

Any other denomination must be rejected.

### Operations

The machine should support the following operations:

1. **Insert a coin**
   The user can insert one or more valid coins. The machine keeps track of the total amount inserted so far.

2. **Select a product**
   The user selects a product by its name (or code). The machine should then:
   - If the product **does not exist** → raise an error (or return an appropriate response).
   - If the product is **out of stock** → return the inserted coins and inform the user.
   - If the inserted amount is **less than the price** → return the inserted coins and inform the user that funds are insufficient.
   - If the inserted amount is **equal to or greater than the price** → dispense the product, decrement the stock, and return the correct **change**.

3. **Cancel**
   The user can cancel the transaction at any time and get all inserted coins back.

### Change
When returning change, the machine should return it using the **fewest possible coins**, based on the denominations available.

You may assume the machine always has enough coins to give change (no need to track the machine's own coin inventory).

## Out of scope
- Persistence (no database, no file storage).
- User interface (no CLI prompt needed — a Ruby API is enough).
- Concurrency.

## Deliverables
- A Ruby implementation (no Rails).
- Unit tests covering the main scenarios.

## Bonus (if time allows)
- Track the machine's own coin inventory and handle the case where it cannot give exact change.
- Allow restocking products.
- Allow an admin to collect the money from the machine.