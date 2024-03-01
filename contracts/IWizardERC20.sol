

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^*;

interface IWizardERC20 {
    
    function mintTo(address account,uint amount) external;
    function balanceOf(address owner) external view returns(uint);
    function transfer(address to, uint value) external;
}