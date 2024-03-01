


import { ethers } from "hardhat";


const mintToken = async () =>{

    const contractAddress = "";

    const deployedToken = await ethers.getContractAt("IWizardERC20", contractAddress);
    await deployedToken.wait();

    const runAm = await deployedToken.mintTo("", 100000);
    await runAm.wait();

    const bal = await deployedToken.balanceOf("");
    await bal.wait();


    console.log(`address of the airdrop balance is ${bal}`);

}


mintToken().catch((error) =>{
    console.log(error);

    process.exitCode = 2;
})