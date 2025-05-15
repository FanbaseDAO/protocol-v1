async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    console.log("Deploying with", deployer.address);
    const Factory = await ethers.getContractFactory("FanbaseMusic");
    const contract = await Factory.deploy();
    await contract.deployed();
    console.log("FanbaseMusic deployed at:", contract.address);
  }
  
  main().catch(e => { console.error(e); process.exit(1); });
  