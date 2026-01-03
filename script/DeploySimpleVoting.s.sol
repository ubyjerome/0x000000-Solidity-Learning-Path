// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {SimpleVoting} from "../project/Simple-Voting.sol";

contract DeploySimpleVoting is Script {
    function run() external {
        vm.startBroadcast();
        new SimpleVoting();
        vm.stopBroadcast();
    }
}
