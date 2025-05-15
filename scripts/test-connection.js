async function main() {
    const provider = new ethers.providers.JsonRpcProvider(process.env.BASE_SEPOLIA_RPC);
    const blockNumber = await provider.getBlockNumber();
    console.log("Connected to baseSepolia. Current block number:", blockNumber);
  }
  main();
  