async function main() {
    const [owner, user] = await ethers.getSigners();
    const Factory = await ethers.getContractFactory("FanbaseMusic");
    const contract = await Factory.deploy();
    await contract.deployed();

    console.log("Deployed to", contract.address);
    const tx = await contract.mint(user.address); // Correctly using user.address
    await tx.wait();
    console.log("Minted token #0 to", user.address);
}

main().catch(console.error);
