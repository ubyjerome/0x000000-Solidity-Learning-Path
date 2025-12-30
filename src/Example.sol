// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Example {
    uint8 public value = 42;

    function setValue(uint8 _value) public {
        value = _value;
    }
}
