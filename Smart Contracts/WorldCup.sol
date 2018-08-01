pragma solidity ^0.4.24;

contract Worldcup {
    string[] public teams;
    int256 public winnerIndex = -1;
    
    constructor() public {
        
    }
    
    // Add Football Team
    function addNewTeam(string _name) public {
        // Validate
        require(keccak256(abi.encodePacked(_name)) != keccak256(abi.encodePacked("")));
        
        teams.push(_name);
    }
    
    // Random the winner
    function randomWinner(string _seed) public returns (int256) {
        // random algorithm
        winnerIndex = int256(uint256(keccak256(abi.encodePacked("Random Prefix", _seed, "Random Srefix"))) % teams.length);
        return winnerIndex;
    }
    
    // Team count
    function teamCount() public view returns (uint256) {
        return teams.length;
    }
    
    // Winner name
    function winnerName() public view returns (string) {
        // Validate
        require(winnerIndex >= 0);
        
        return teams[uint256(winnerIndex)];
    }
}
