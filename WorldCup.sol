pragma solidity ^0.4.24;

contract Worldcup {
    string[] public teams;
    int256 public winner = -1;
    
    constructor() public {
        
    }
    
    function addNewTeam(string _name) public {
        teams.push(_name);
    }
    
    function randomWinner(uint256 nonce) public returns (int256) {
        // random algorithm
        winner =  int256((nonce * 27999939614659217371136582730618069762179071 ^ 22) % teams.length);
        return winner;
    }
    
    function teamCount() public view returns (uint256) {
        return teams.length;
    }
}
