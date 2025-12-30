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
