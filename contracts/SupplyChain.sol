
pragma solidity ^0.8.0;
contract SupplyChain {
    struct Item {
        uint id;
        address owner;
    }
    mapping(uint => Item) public items;
    bool private inProgress;

    // Events
    event ItemAdded(uint itemId, address owner);
    event ItemTransferred(uint itemId, address from, address to, uint value);

    // Reentrancy guard
    modifier nonReentrant() {
        require(!inProgress, "Non-reentrancy lock");
        inProgress = true;
        _;
        inProgress = false;
    }

    // Add a new item
    function addItem(uint itemId, address initialOwner) public {
        require(items[itemId].owner == address(0), "Item ID already exists");
        require(initialOwner != address(0), "Invalid owner address");

        items[itemId] = Item({
            id: itemId,
            owner: initialOwner
        });

        emit ItemAdded(itemId, initialOwner);
    }

    // Transfer item ownership
    function transferItem(uint itemId, address newOwner)
        public
        payable
        nonReentrant
    {
        Item storage item = items[itemId];

        require(item.owner != address(0), "Invalid Item ID");
        require(item.owner == msg.sender, "Not the owner");
        require(newOwner != address(0), "Invalid new owner");
        require(newOwner != item.owner, "Cannot transfer to same owner");

        uint requiredValue = 1 ether;
        require(msg.value >= requiredValue, "Insufficient transaction value");

        address previousOwner = item.owner;

        // Effects
        item.owner = newOwner;

        // Interaction
        (bool sent, ) = payable(previousOwner).call{value: msg.value}("");
        require(sent, "Payment failed");

        emit ItemTransferred(itemId, previousOwner, newOwner, msg.value);
    }
}
