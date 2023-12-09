const { expect } = require("chai")
const { ethers } = require("hardhat")


describe("AucEngine", function () {
    let owner
    let seller
    let buyer
    let auct


    beforeEach(async function () {
        [owner, seller, buyer] = await ethers.getSigners()

        const AucEngine = await ethers.getContractFactory("AucEngine", owner)
        auct = await AucEngine.deploy()
    })


    it("sets owner", async function() {
        const currentOwner = await auct.owner()
        console.log("currentOwner::", currentOwner)
        expect(currentOwner).to.eq(owner.address)
    })

    async function getTimestamp(bn) {
        return (
            await ethers.provider.getBlock(bn) // provider подключается к блокчейну и смотрим время по номеру блока
        ).timestamp                            // только метку времени
    }


    it("create auction correctly", async function () {
        const duration = 60
        const tx = await auct.createAuction(
            ethers.parseEther("0.0001"),                  // принимает в eth и конвертирует в wei
            3,                                                  // будем сбрасывать 3wei в секунду
            "fake item",
            duration                                                  // 60 секунд
        )

        const cAuction = await auct.auctions(0)
        expect(cAuction.item).to.eq("fake item")
        const ts = await getTimestamp(tx.blockNumber)
        expect(cAuction.endsAt).to.eq(ts + duration)
    })

    function delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms))
    }

    it("allow to buy", async function() {
        const duration = 60
        await auct.connect(seller).createAuction(
            ethers.parseEther("0.0001"),                  // принимает в eth и конвертирует в wei
            3,                                                  // будем сбрасывать 3wei в секунду
            "fake item",
            duration                                                  // 60 секунд
        )

        this.timeout(5000)                              // текущий тест работает до 5 сек, если больше, то ошибка
        await delay(1000)

        const buyTx = await auct.connect(buyer).
            buy(0, { value: ethers.parseEther("0.0001") })

        const cAuction = await auct.auctions(0)
        const finalPrice = cAuction.finalPrice
        console.log("finalPrice::", finalPrice)
        await expect(() => buyTx).
            to.changeEtherBalance(
                seller, finalPrice - Math.floor((finalPrice * 10) / 100)
            )
    })
})