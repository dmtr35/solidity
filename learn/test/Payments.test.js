// const {expect} = require("chai")
// const {ethers} = require("hardhat")


// describe("Payments", function() {
//     // сначала разворачиваем блокчейн
//     let acc1
//     let acc2
//     let payments

//     beforeEach(async function() {
//         // демо акаунт, получаем информация о этом акаунте
//         [acc1, acc2] = await ethers.getSigners()
//         // получаем информацию о скомпилированой версии смарт контракта
//         const Payments = await ethers.getContractFactory("Payments", acc1)
//         payments = await Payments.deploy() // отправляем транзакцию
//     })

//     it("shoud be deployed", async function() {
//         // проверяем адрес смарт контракта
//         expect(payments.runner.address).to.be.properAddress
//     })

//     it("shoud have 0 ethe by default", async function() {
//         const balance = await payments.currentBalance()
//         expect(balance).to.eq(0)
//     })

//     it("shoude be possible to send funds", async function() {
//         const sum = 100
//         const msg = "hello"
//         const tx = await payments.connect(acc2).pay(msg, {value: sum})  // (connect(acc2)) деньги внесет 2 акк
//         // const tx = await payments.pay(msg, {value: sum})   //value 100gwei

//         await expect(() => tx)
//             // .to.changeEtherBalance(acc2, -sum) // проверка что на acc2 стало на 100gwei меньше
//             .to.changeEtherBalances([acc2, payments], [-sum, sum]) // на acc2 на -sum, на смартконтракте +sum
//         await tx.wait()

//         const newPayment = await payments.getPayment(acc2.address, 0)
//         expect(newPayment.message).to.eq(msg)
//         expect(newPayment.amount).to.eq(sum)
//         expect(newPayment.from).to.eq(acc2.address)
//     })

//     // it("shoude info tx", async function() {

//     // })
// })