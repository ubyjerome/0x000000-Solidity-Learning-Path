// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";  
// import {Example} from "../src/Example.sol";   
import {FunctionContract} from "../src/Function.sol";

contract DeployExample is Script {
    function run() external {
        vm.startBroadcast();
        // new Example(); 
        new FunctionContract();
        vm.stopBroadcast();
    }
}
