


// SPDX-License-Identifier: MIT
pragma solidity ^*;


contract Game{

    mapping (address => uint8) private scores;
    mapping (address => bool) private hasEnded;
    mapping (address => uint8) private numberOfPlayed;
    mapping (address => bool) private onceVisited;
    address[] private participants;
    uint8 private uniqueNumber;

    constructor(uint8 _uniqueNumber) checkUniqueNumberInput(_uniqueNumber){
        uniqueNumber = _uniqueNumber;
    }

    modifier checkUniqueNumberInput(uint8 _uniqueNumber){
        require(_uniqueNumber > 0, "Number must be greater than 0");
        require(_uniqueNumber < 11, "number must be within the range of 1 - 10");
        _;
    }
    
    modifier hasPlayerGuessLapEnded(address player){
        require(!hasEnded[player], "you have elapsed your guess period");
        _;
    }
    
    function playGame(address player, uint8 luckyNumber) external hasPlayerGuessLapEnded(player) checkUniqueNumberInput(luckyNumber){

        checkIfOnceVisited(player);

        if (luckyNumber == uniqueNumber)
            scores[player] =  scores[player] + 2;
        
        numberOfPlayed[player] = numberOfPlayed[player] + 1;

        if (numberOfPlayed[player] == 3) {
            hasEnded[player] = true;
            if (scores[player] == 0) scores[player] = scores[player] + 1;
        }
    }

    function checkIfOnceVisited(address player) private {
        if(!onceVisited[player]){
            onceVisited[player] = true;
            participants.push(player);
        }
    }

    function getPlayerStatus(address player) external view returns (uint8 score, bool elasped){
        score = scores[player];
        elasped = hasEnded[player];
    }

    function getAllParticipants() external view returns(address[] memory){
        return participants;
    }
}