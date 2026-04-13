
# 🧾 Supply Chain Smart Contract

A simple Ethereum-based smart contract for tracking ownership of items in a supply chain.

## 📌 Overview
This project implements a basic supply chain system where:
* Items can be registered on-chain
* Ownership of items can be transferred securely
* Payments can be attached to ownership transfers

The contract is written in **Solidity** and designed for deployment on Ethereum-compatible blockchains.


## 🚀 Features
* ✅ Add new items with unique IDs
* 🔄 Transfer ownership securely
* 💰 Enforced payment during transfers
* 🔒 Protection against reentrancy attacks
* 📢 Event logging for blockchain tracking


## 📂 Contract Structure
### `Item`
Represents a supply chain item:

* `id`: Unique identifier
* `owner`: Current owner address

### Storage
* `mapping(uint => Item) public items;`

## 🛠 Functions
### ➕ `addItem(uint itemId, address initialOwner)`
Registers a new item.

**Requirements:**
* Item must not already exist
* Owner must be a valid address

### 🔁 `transferItem(uint itemId, address newOwner)`
Transfers ownership of an item.

**Requirements:**
* Caller must be current owner
* Item must exist
* New owner must be valid and different
* Minimum payment: `1 ether`

**Behavior:**
* Ownership is transferred
* Payment is sent to the previous owner
  
## 🔐 Security Features
### Non-Reentrancy Guard
Prevents reentrancy attacks using a mutex (`nonReentrant` modifier).

### Checks-Effects-Interactions Pattern
Ensures safe execution order:
1. Validation checks
2. State updates
3. External calls

## 📢 Events
* `ItemAdded(uint itemId, address owner)`
* `ItemTransferred(uint itemId, address from, address to, uint value)`
These events help track activity on-chain and integrate with frontends.

## 🧪 Testing Ideas

* Add multiple items
* Transfer ownership with correct ETH
* Try invalid transfers (should fail)
* Test reentrancy protection


## ⚠️ Limitations
* No role-based access control (anyone can add items)
* No item metadata (name, description, etc.)
* Mapping is not iterable (cannot list all items)

## 🔮 Future Improvements
* 👤 Role-based system (Manufacturer, Distributor, Retailer)
* 📦 Add item metadata (IPFS integration)
* 📊 Frontend dashboard (React + Web3)
* 🧾 Transaction history tracking

-
