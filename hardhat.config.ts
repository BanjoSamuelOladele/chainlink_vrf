import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const {PRIVATE_KEY, MUMBAI_TEST_URL} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks:{
    sepolia:{
      url: "",
      accounts: []
    },
    mumbai:{
      url: MUMBAI_TEST_URL,
      accounts: [PRIVATE_KEY as string]
    }
  }
};

export default config;
