

import { ethers } from "hardhat";


const deployVRF = async () => {
    const vrf = await ethers.deployContract("VRF");
    await vrf.waitForDeployment();


    console.log(`deployed vrf address is ${vrf.target}`);
}


deployVRF().catch((error) =>{
    console.log(error);
    process.exitCode = 2;
});