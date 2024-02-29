


// SPDX-License-Identifier: MIT
pragma solidity ^*;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract WizardERC20 is ERC20, Ownable {

    constructor() ERC20("wizard", "wizT") Ownable(msg.sender){}

    function mintTo(address account,uint amount) external onlyOwner{
        _mint(account, (amount * (10 ** decimals())));
    }
}