const hre = require("hardhat");

// to run the script:
//      npx hardhat run scripts/verify/native-currency-faucet.js --network zkSyncSepoliaTestnet

async function main() {
  const contractAddress = "<YOUR CONTRACT ADDRESS>"; // TODO: Replace with deployed contract address
  const constructorArgs = [24 * 60 * 60, ethers.utils.parseEther("0.01")]; // TODO: Set constructor params (cooldown and requestAmount)

  console.log("Verifying contract.");
  await verify(
    contractAddress,
    "contracts/NativeCurrencyFaucet.sol:NativeCurrencyFaucet",
    constructorArgs
  );
}

async function verify(address, contract, args) {
  try {
    return await hre.run("verify:verify", {
      address: address,
      contract: contract,
      constructorArguments: args,
    });
  } catch (e) {
    console.log(address, args, e);
  }
}

main()
  .then(() => process.exit(0))
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });
