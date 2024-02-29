


// SPDX-License-Identifier: MIT
pragma solidity ^*;
// import {Game} from "./Game.sol";
import "./Game.sol";
import "./WizardERC20.sol";

contract AirDrop{

    uint private elaspedParticipationPeriod;
    Game private game;
    address private onlyOwner;

    mapping (address => bool) private hasRegistered;


    modifier onlyPlayer{
        require(hasRegistered[msg.sender], "you are not a valid participant");
        _;
    }


    event SuccessfullyRegisterred(address);
    event ParticipantParticipation(address indexed );
    error DuplicateRegistration();
    error NotAParticipantError();
    error PeriodOfParticipationEnded();

    function registerUser(address user) external {
        if (hasRegistered[user]) revert DuplicateRegistration();
        hasRegistered[user] = true;
        emit SuccessfullyRegisterred(user);
    }


    function participate(uint8 luckyNumber) external onlyPlayer{
        if (block.timestamp <= elaspedParticipationPeriod){
            game.playGame(msg.sender, luckyNumber);
            emit  ParticipantParticipation(msg.sender);
        }
        else revert PeriodOfParticipationEnded();
    }

    // function giveReward() 

}