


// SPDX-License-Identifier: MIT
pragma solidity ^*;


contract Game{

    mapping (address => uint8) private scores;
    mapping (address => bool) private hasEnded;
    mapping (address => uint8) private numberOfPlayed;
    uint8 private uniqueNumber;

    constructor(uint8 _uniqueNumber){
        uniqueNumber = _uniqueNumber;
    }

    
    modifier hasPlayerGuessLapEnded(address player){
        require(!hasEnded[player], "you have elapsed your guess period");
        _;
    }
    
    function playGame(address player, uint8 luckyNumber) external hasPlayerGuessLapEnded(player) {
        require(luckyNumber > 0, "Number must be greater than 0");
        require(luckyNumber < 11, "number must be within 1 - 10");

        if (luckyNumber == uniqueNumber)
            scores[player] =  scores[player] + 2;
        
        numberOfPlayed[player] = numberOfPlayed[player] + 1;

        if (numberOfPlayed[player] == 3) 
            hasEnded[player] = true;


    }

    function getPlayerStatus(address player) external view returns (uint8 score, bool elasped){
        score = scores[player];
        elasped = hasEnded[player];
    }
}