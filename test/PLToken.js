let PlToken = artifacts.require("PLToken");

contract('PLToken', (account) =>{
    it('set total supply upon deployment', () => {
        return PlToken.deployed().then((i) => {
            instance = i;
            return instance.totalSupply();
        }).then(supply => {
           assert.equal(supply.toNumber(), 100000);
        });
    });
});