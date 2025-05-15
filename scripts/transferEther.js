const hre = require("hardhat");

async function main() {
  const recipientAddress = "0xFC94Ab3a3546BD3b9A88bb3b317e954C7C29B4D5";
  const senderPrivateKey = "0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e"; // Private key of Account #19

  const wallet = new hre.ethers.Wallet(senderPrivateKey, hre.ethers.provider);

  const tx = {
    to: recipientAddress,
    value: hre.ethers.utils.parseEther("100.0"), // Access parseEther via hre.ethers.utils
  };

  const transaction = await wallet.sendTransaction(tx);
  console.log("Transaction hash:", transaction.hash);

  await transaction.wait();
  console.log("Ether transfer successful!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });