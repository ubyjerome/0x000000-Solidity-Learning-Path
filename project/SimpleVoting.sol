// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin;
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

    function isAdmin(address user) external view returns (bool) {
        if (msg.sender == admin) {
            return true;
        }
        return user == admin;
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

    function addCandidate(string calldata name) external onlyAdmin {
        require(bytes(name).length > 0, "Name cannot be empty");
        candidates.push(Candidate({name: name, voteCount: 0}));
    }

    function viewResults() external view returns (Candidate[] memory) {
        return candidates;
    }

    function vote(uint candidateIndex) external {
        require(isVoter[msg.sender], "Not eligible to vote");
        require(!hasVoted[msg.sender], "Already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }
}
