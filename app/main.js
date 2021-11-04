const express = require("express");
const { verify } = require("hcaptcha");
const { keccak256, recoverAddress } = require("ethers/lib/utils");
const { Wallet, Contract } = require("ethers");
const interface = require("./DelegateEvidence.json");

const app = express();

const secret = process.env.HCAPTCHA_SECRET;

const privateKey = process.env.PRIVATE_KEY;

const wallet = new Wallet(privateKey);

const contract = new Contract(process.env.DELEGATE_EVIDENCE_ADDRESS, interface);

app.post("/submit", async (req, res) => {
  try {
    const { address, token, signature } = req.query;
    const hash = keccak256(token);
    const signer = recoverAddress(hash + address, signature);
    if (signer !== address) throw "Invalid signature.";
    const data = await verify(secret, token);
    if (!data.success) throw "Invalid captcha.";
    await contract.submitEvidence(
      address,
      timestamp,
      wallet.address,
      hash +
        signature +
        (await wallet.signMessage(
          hash + address + timestamp + signature + wallet.address
        ))
    );
    res.end(200);
  } catch (error) {
    res.end(502);
  }
});

app.listen(8080, () => {
  console.log("Listening on port 8080.");
});
