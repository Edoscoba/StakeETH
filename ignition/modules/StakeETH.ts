const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("StakeModule", (m) => {
 

  const Stake = m.contract("StakingETH",[])

  return { Stake};
});
