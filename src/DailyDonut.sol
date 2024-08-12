// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract DailyDonut {
    mapping(address => uint256) public lastClaimDay;
    uint256 public claimId;

    event Transfer(address indexed from, address indexed to, uint256 claimId);

    function getCurrentDay() public view returns (uint256) {
        return block.timestamp / 1 days;
    }

    function claimDonut() public {
        uint256 currentDay = getCurrentDay();

        require(
            lastClaimDay[msg.sender] < currentDay,
            "You can only claim once per day"
        );

        lastClaimDay[msg.sender] = currentDay;
        claimId++;
        emit Transfer(address(0), msg.sender, claimId);
    }

    function timeUntilNextClaim(
        address _address
    ) public view returns (uint256) {
        uint256 currentDay = getCurrentDay();
        if (lastClaimDay[_address] < currentDay) {
            return 0;
        }
        uint256 nextMidnight = (currentDay + 1) * 1 days;
        return nextMidnight - block.timestamp;
    }

    function canClaimToday(address _address) public view returns (bool) {
        return lastClaimDay[_address] < getCurrentDay();
    }
}
