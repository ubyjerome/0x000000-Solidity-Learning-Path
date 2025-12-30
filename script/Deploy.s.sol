// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Example.sol";

contract DeployExample is Script {
    function run() external {
        vm.startBroadcast();
        new Example();
        vm.stopBroadcast();
    }
}
