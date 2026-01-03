// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    mapping(address => bool) public isVoter;
    mapping(address => bool) public hasVoted;
    address[] public voterList;

    Candidate[] public candidates;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }



    function addEligibleAddressForVote(address voter) external onlyAdmin {
        require(voter != address(0), "Invalid address");
        require(!isVoter[voter], "Already registered");
        isVoter[voter] = true;
        voterList.push(voter);
    }

    function addVoters(address[] calldata voters) external onlyAdmin {
        for (uint i = 0; i < voters.length; i++) {
            address voter = voters[i];
            if (voter != address(0) && !isVoter[voter]) {
                isVoter[voter] = true;
                voterList.push(voter);
            }
        }
    }

    function viewEligibleVoters() external view returns (address[] memory) {
        return voterList;
    }

    // add candidate
    // vote for candidate
    // view results
}





