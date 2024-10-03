// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StakingETH {
    address owner;
    constructor() {
        owner = msg.sender;
    }
    struct User {
        address userAddress;
        uint timeStart;
        uint duration;
        uint amountStaked;
    }

    // User[] users;

    mapping(address => User) userStaking;

    function addStaking(uint _duration, uint _amountStaked) external payable {
        require(msg.sender != address(0), "address zero detected");
        require(_amountStaked > 0, "can't stake zero amount");

        uint _timeStart = block.timestamp;
        uint _durationStaking = _duration;

        userStaking[msg.sender] = (User(msg.sender, _timeStart, _durationStaking, _amountStaked));
            userStaking[msg.sender].amountStaked += _amountStaked;
    }

    function userStakingTimeStart(
        address _address
    ) external view returns (uint) {
        return userStaking[_address].timeStart;
    }

    function userStakingTimeEnd(address _address) external view returns (uint) {
        return userStaking[_address].timeStart + userStaking[_address].duration;
    }

    function userStakingBalance(address _address) external view returns (uint) {
        return userStaking[_address].amountStaked;
    }

    function userStakingReward(address _address) external view returns (uint) {
        uint _timeEnd = userStaking[_address].timeStart +
            userStaking[_address].duration;
        uint _timeStart = userStaking[_address].timeStart;
        uint _durationStaking = (userStaking[_address].duration);
        uint _amountStaked = (userStaking[_address].amountStaked);

        uint _rewardAmountStaked = (_amountStaked * _timeEnd - _timeStart) /
            _durationStaking;
        return _rewardAmountStaked;
    }

    function withdraw() external payable {
        require(msg.sender != address(0), "address zero detected");
        require(msg.value > 0, "amount to be withdrawn is zero");
        require(
            userStaking[msg.sender].amountStaked >= msg.value,
            "cant withdraw more than your balance"
        );

          uint _timeEnd = userStaking[msg.sender].timeStart +
            userStaking[msg.sender].duration;
        uint _timeStart = userStaking[msg.sender].timeStart;
        uint _durationStaking = (userStaking[msg.sender].duration);
        uint _amountStaked = (userStaking[msg.sender].amountStaked);

        uint _rewardAmountStaked = (_amountStaked * _timeEnd - _timeStart) /
            _durationStaking;

        userStaking[msg.sender].amountStaked -= msg.value;
    }
}
