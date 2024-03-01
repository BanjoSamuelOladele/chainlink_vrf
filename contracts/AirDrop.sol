


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import {Game} from "./Game.sol";
import "./WizardERC20.sol";
import {IVRF} from "./IVRF.sol";

contract AirDrop{

    uint private elaspedParticipationPeriod;
    Game private game;
    address private owner;
    IVRF private ivrf;

    mapping (address => bool) private hasRegistered;
    address[] private players;


    constructor(address vrfAddress, uint8 uniqueNumber, uint elaspedPeriod){
        ivrf = IVRF(vrfAddress);
        game = new Game(uniqueNumber);
        elaspedParticipationPeriod = elaspedPeriod;
    }

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
        players.push(user);
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