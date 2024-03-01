


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import {Game} from "./Game.sol";
// import "./WizardERC20.sol";
import {IVRF} from "./IVRF.sol";
import "./IWizardERC20.sol";

contract AirDrop{

    uint private elaspedParticipationPeriod;
    Game private game;
    address private owner;
    IVRF private ivrf;
    IWizardERC20 iWiz;


    mapping (address => bool) private hasRegistered;
    address[] private players;


    constructor(address vrfAddress, uint8 uniqueNumber, uint elaspedPeriod){
        ivrf = IVRF(vrfAddress);
        game = new Game(uniqueNumber);
        elaspedParticipationPeriod = elaspedPeriod * 60;
        owner = msg.sender;
    }

    modifier onlyPlayer{
        require(hasRegistered[msg.sender], "you are not a valid participant");
        _;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
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

    
    function giveReward(uint totalNumberOfPossibleWinners) external onlyOwner{
        require(block.timestamp > elaspedParticipationPeriod, "not yet specified closing period");
        // uint[] storage number;
        for (uint i = 0; i < totalNumberOfPossibleWinners; i++) {
            uint result = ivrf.requestRandomWords() % game.getAllParticipants().length;
            address luckyPlayer = game.getParticipantAddressWithIndex(result);
            (uint score, ) = game.getPlayerStatus(luckyPlayer);

        }
    }

}