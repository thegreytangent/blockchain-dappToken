const PLToken = artifacts.require("PLToken");

module.exports = function (deployer) {
  deployer.deploy(PLToken);
};
