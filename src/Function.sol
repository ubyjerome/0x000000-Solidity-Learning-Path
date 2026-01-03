// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FunctionContract {
    uint256 private storedValue;

    function example1(uint256 a, uint256 b) private pure returns (uint256) {
        return a + b;
    }

    function example2() internal view returns (uint256) {
        return storedValue;
    }

    function example3(uint256 newValue) public payable {
        storedValue = newValue;
    }

    function example4() external pure returns (string memory) {
        return "hello";
    }

    // function usePrivateFunction(uint256 x, uint256 y) public pure returns (uint256) {
    //     return example1(x, y);
    // }

    // function readStoredValue() public view returns (uint256) {
    //     return example2();
    // }

    // function callExternal() public view returns (string memory) {
    //     return this.example4();
    // }

    // function getBalance() public view returns (uint256) {
    //     return address(this).balance;
    // }
}
