// const { expect } = require("chai")
// const { ethers } = require("hardhat")


// describe("Demo", function () {
//     let owner
//     let other_addr
//     let demo


//     beforeEach(async function () {
//         [owner, other_addr] = await ethers.getSigners()

//         const DemoContract = await ethers.getContractFactory("Demo", owner)
//         demo = await DemoContract.deploy()
//     })

//     // функция отправки денег
//     async function sendMoney(sender) {
//         const amount = 100
//         const txData = {
//             to: demo.runner.address,
//             value: amount
//         }

//         const tx = await sender.sendTransaction(txData);
//         await tx.wait();
//         return [tx, amount]
//     }

//     it("Should allow to send money", async function () {
//         const [sendMoneyTx, amount] = await sendMoney(other_addr)
//         // console.log('sendMoneyTx::', sendMoneyTx)

//         await expect(() => sendMoneyTx)
//             .to.changeEtherBalance(owner, amount);

//         // =============================================================
//         // const timestamp = (await ethers.provider.getBlock(sendMoneyTx.blockNumber)).timestamp
//         // // console.log(timestamp)
//         // console.log("Event emitted:", sendMoneyTx.events);
//         // await expect(sendMoneyTx)
//         //     .to.emit(demo, "Paid")
//         //     .withArgs(other_addr.address, amount, timestamp)
//         // =============================================================

//     })
// })