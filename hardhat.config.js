require("@nomiclabs/hardhat-ethers");
require("dotenv").config();


const { BASE_SEPOLIA_RPC, DEPLOYER_PRIVATE_KEY } = process.env;

module.exports = {
    solidity: "0.8.20",
    networks: {
        baseSepolia: {
            url: BASE_SEPOLIA_RPC,
            accounts: [DEPLOYER_PRIVATE_KEY],
            chainId: 84532
        },
        localhost: {
            url: "http://127.0.0.1:8545", // Default Hardhat local network URL
            accounts: [process.env.DEPLOYER_PRIVATE_KEY] // Ensure this key is available for local testing
        }
    }
};
