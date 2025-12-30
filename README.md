# My Solidity + Foundry Local Development Guide For My Solidity Learning/Development Path

This README is my personal record of everything I’ve learned about developing, deploying, and interacting with Solidity contracts locally using **VS Code + Foundry + Anvil**, without relying on Remix.

---

## 1. Prerequisites I Installed

* **Node.js** – needed for tooling and scripts.
* **Git** – for cloning repositories and managing libraries.
* **VS Code / VS Code Insiders** – my editor of choice.
* **VS Code Extensions I Installed**:

  * `Solidity` by Juan Blanco for syntax highlighting and IntelliSense.
  * Optionally, Foundry extension for snippets.

---

## 2. Installing Foundry

I installed Foundry using:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

I verified the installation with:

```bash
forge --version
anvil --version
```

---

## 3. Initializing a Solidity Project

I created a new project:

```bash
forge init my-project
cd my-project
```

This gave me the following structure:

```
my-project/
├── src/        # Where I put my contracts
├── test/       # Where I write tests
├── script/     # Deployment and interaction scripts
└── foundry.toml # My configuration
```

---

## 4. Writing My First Contract

In `src/Example.sol`, I wrote:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Example {
    uint8 public value = 42;

    function setValue(uint8 _value) public {
        value = _value;
    }
}
```

---

## 5. Compiling

I compiled my contracts with:

```bash
forge build
```

Old artifacts sometimes caused warnings, so I ran:

```bash
forge clean
forge build
```

---

## 6. Testing

I wrote tests in `test/Example.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Example.sol";

contract ExampleTest is Test {
    Example example;

    function setUp() public {
        example = new Example();
    }

    function testInitialValue() public {
        assertEq(example.value(), 42);
    }

    function testSetValue() public {
        example.setValue(100);
        assertEq(example.value(), 100);
    }
}
```

I ran tests with:

```bash
forge test
```

---

## 7. Deploying Locally

I started a local blockchain with Anvil:

```bash
anvil
```

Then I created a deployment script in `script/Deploy.s.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Example.sol";

contract DeployExample is Script {
    function run() external {
        vm.startBroadcast(0xYOUR_PRIVATE_KEY); // My deployer account
        new Example();
        vm.stopBroadcast();
    }
}
```

And deployed with:

```bash
forge script script/Deploy.s.sol:DeployExample --broadcast --rpc-url localhost --private-key 0xYOUR_PRIVATE_KEY
```

I learned that:

* The **sender account / private key** is the one paying for deployment and is `msg.sender` in the constructor.
* `vm.startBroadcast()` and `vm.stopBroadcast()` are Foundry cheatcodes that let me sign transactions from scripts.

---

## 8. Interacting with the Contract

I created `script/Interact.s.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Example.sol";

contract InteractExample is Script {
    function run() external {
        vm.startBroadcast(0xYOUR_PRIVATE_KEY);

        Example example = Example(0xDEPLOYED_CONTRACT_ADDRESS);

        // Read current value
        uint8 current = example.value();
        console.log("Current value:", current);

        // Update value
        example.setValue(99);
        console.log("Value updated!");

        vm.stopBroadcast();
    }
}
```

Then ran:

```bash
forge script script/Interact.s.sol:InteractExample --broadcast --rpc-url localhost --private-key 0xYOUR_PRIVATE_KEY
```

I also learned I can interact using **`cast`**:

```bash
cast call 0xDEPLOYED_CONTRACT_ADDRESS "value() returns (uint8)" --rpc-url localhost

cast send 0xDEPLOYED_CONTRACT_ADDRESS "setValue(uint8)" 123 --private-key 0xYOUR_PRIVATE_KEY --rpc-url localhost
```

---

## 9. Using Foundry Config

I set up `foundry.toml`:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
sender = "0xMY_ETH_ADDRESS"

[rpc_endpoints]
localhost = "http://127.0.0.1:8545"
```

* `sender` must be an **Ethereum address**, not a private key.
* Private keys must be passed in scripts or via CLI (`--private-key`).
* RPC endpoints can be named and referenced instead of hardcoding URLs.

---

## 10. Key Learnings

* VS Code is **just an editor**; Foundry handles compilation, testing, and deployment.
* `vm.*` cheatcodes only work in scripts and tests inheriting from `Script` or `Test`.
* The sender account is the one deploying the contract and paying gas.
* `cast` is a CLI tool for quick interactions without writing a script.
* Always clean builds when source files are deleted or changed.
* Local deployments and interactions on Anvil fully simulate Ethereum behavior.
