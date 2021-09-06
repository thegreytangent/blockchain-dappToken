let PLToken = artifacts.require("PLToken");

contract('PLToken', (account) =>{
    var instance;

    it("Init contract correct values", () => {
        return PLToken.deployed().then(i => {
            instance = i;
            return instance.name();
        }).then(tokenName => {
            assert.equal(tokenName, "PLToken");
            return instance.symbol();
        }).then(symbol => {
            assert.equal(symbol, "PLCOIN");
        })
    });


    it('set total supply upon deployment', () => {
        return PLToken.deployed().then((i) => {
            instance = i;
            return instance.totalSupply();
        }).then(supply => {
           assert.equal(supply.toNumber(), 100000);
           return instance.balanceOf(account[0]);
        }).then(adminBalance => {
            assert.equal(adminBalance.toNumber(), 100000);
        });
    });

    it('transfer token ', () => {
        return PLToken.deployed().then((i) => {
            instance = i;
            return instance.transfer.call(account[1], 9999999999999999999);
        }).then(assert.fail).catch(err => {
            assert( err.message.indexOf('overflow') >= 0 , 'error must contain revert');
            return instance.transfer.call(account[1], 2500, {from: account[0]});
        }).then(success => {
            assert.equal(success, true, "It should be true");
            return instance.transfer(account[1], 2500, {from: account[0]});
        }).then(receipt => {
            assert.equal(receipt.logs[0].event, "Transfer");
            assert.equal(receipt.logs[0].args._from, account[0]);
            assert.equal(receipt.logs[0].args._to, account[1]);
            return instance.balanceOf(account[1]);
        }).then(balance => {
            assert.equal(balance.toNumber(), 2500);
            return instance.balanceOf(account[0]);
        }).then(balance => {
            assert.equal(balance.toNumber(), 97500);
        });
    });



});