


import {ethers} from "hardhat";


const deployToken = async () => {

    const deplyed = await ethers.deployContract("WizardERC20");
    await deplyed.waitForDeployment();


    console.log(`token address is at ${deplyed.target}`)
}


deployToken().catch((error) => {
    console.log(error);
    process.exitCode = 1;
})