// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract AucEngine {
    address public owner;                         // владелец площадки
    uint constant DURATION = 2 days;              // constant задается сразу, менять нельзя
    // immutable можно задать в конструкторе
    uint constant FEE = 10;                       // 10% заберает площадка
    struct Auction {
        address payable seller;                   // адрес продавца
        uint startingPrice;                       // стартовая цена
        uint finalPrice;                          // конечная цена
        uint startAt;                             // начало аукциона
        uint endsAt;                              // конец аукциона
        uint discountRate;                        // сколько мы будес сбрасывать от цены
        string item;                              // то что продаем
        bool stopped;                             // закончился аукцион или нет
    }

    Auction[] public auctions;                    // массив аукционов

    // событие это запись которую мы сделаем в журнале событий, и этот журнал пристиковывается к блокчейн
    event AuctionCreated(uint index, string itemName, uint startingPrice, uint duration);
    event AuctionEnded(uint index, uint finalPrice, address winner);

    constructor() {
        owner = msg.sender;                       // тот кто развернул смарт контракт, будет владельцем
    }

    function createAuction(uint _startingPrice, uint _discountRate, string calldata _item, uint _duration) public {
    // calldata - неизменяемая вещь которая хранится в памяти, затем мы положим ее в массив
    // _duration если равен 0, но будем брать дефолтное значение
    // external - к функции можно обращаться только из вне смарт контракта
    // создать аукцион может любой человек
        uint duration = _duration == 0 ? DURATION : _duration;   // проверка, передал ли пользователь duration

        require(_startingPrice >= _discountRate * duration, "incorrect starting price"); // проверка, стартовое значение правильно

        Auction memory newAuction = Auction({
            seller: payable(msg.sender),               // продавец, payable чтобы перевести ему деньги
            startingPrice: _startingPrice,
            finalPrice: _startingPrice,
            discountRate: _discountRate,
            startAt: block.timestamp,
            endsAt: block.timestamp + duration,
            item: _item,
            stopped: false
        });

        auctions.push(newAuction);                     // добавляем новый аукцион в массив с аукционами

        emit AuctionCreated(auctions.length - 1, _item, _startingPrice, duration);
        // emit - мы записываем в журнал такие данные, приложение (к примеру)на ректе может отслеживать его и отреагировать
    }


    // function stop(uint index) public {
    //     Auction storage cAuction = auctions[index];
    //     cAuction.stopped = true;
    // }


    function getPriceFor(uint index) public view returns(uint) { // позволит брать цену для конкретного аукциона на текущий момент времени
        Auction storage cAuction = auctions[index];              // находим нужный аукцион из массива по index
        require(!cAuction.stopped, "stopped!");                  // проверка, идет ли аукцион
        uint elapsed = block.timestamp - cAuction.startAt;       // сколько прошло с момента начала аукциона
        uint discount = cAuction.discountRate * elapsed;         // сколько нужно скинуть
        return cAuction.startingPrice - discount;                // текущая цена
    } 

    function buy(uint index) external payable {
        Auction memory cAuction = auctions[index];
        require(!cAuction.stopped, "stopped!");
        require(block.timestamp < cAuction.endsAt, "ended!");
        uint cPrice = getPriceFor(index);                        // узнаем текущую цену на товар
        require(msg.value >= cPrice, "not enough funds!");       // проверка, достаточно ли денег прислал покупатель
        cAuction.stopped = true;                                 // останавливаем аукцион
        cAuction.finalPrice = cPrice;                            // фиксируем конечную цену аукциона
        uint refund = msg.value - cPrice;                        // если покупатель заплатил больше, нужно вернуть излишек
        if (refund > 0) {                                        
            payable(msg.sender).transfer(refund);                // возвращаем лишние деньги
        }
        cAuction.seller.transfer(
            cPrice - ((cPrice * FEE) / 100)                      // отправляем продавцу деньги, за вычетом 10%
        );
        emit AuctionEnded(index, cPrice, msg.sender);            // порождаем собитие, какой аук закончен, и за какую цену
    }


}