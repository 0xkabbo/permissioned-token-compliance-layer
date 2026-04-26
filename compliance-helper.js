const { ethers } = require("ethers");

async function checkAndVerify(registryAddress, userAddress, adminSigner) {
    const abi = ["function verify(address account) external", "function isVerified(address account) view returns (bool)"];
    const registry = new ethers.Contract(registryAddress, abi, adminSigner);

    const status = await registry.isVerified(userAddress);
    if (!status) {
        console.log(`Address ${userAddress} is not verified. Sending transaction...`);
        const tx = await registry.verify(userAddress);
        await tx.wait();
        console.log("Address verified successfully.");
    } else {
        console.log("Address is already compliant.");
    }
}

module.exports = { checkAndVerify };
