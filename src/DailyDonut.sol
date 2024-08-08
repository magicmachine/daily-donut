// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract DailyDonut {
    mapping(address => uint256) public lastClaimTimestamp;

    uint256 public _claimId;

    event Transfer(address indexed from, address indexed to, uint256 claimId);

    function claimDonut() public {
        require(lastClaimTimestamp[msg.sender] == 0 || block.timestamp >= lastClaimTimestamp[msg.sender] + 24 hours, "You can only claim once every 24 hours");

        lastClaimTimestamp[msg.sender] = block.timestamp;

        _claimId++;

        emit Transfer(address(0), msg.sender, _claimId);
    }

    // Function to check the time remaining until next claim
    function timeUntilNextClaim() public view returns (uint256) {
        uint256 timeSinceLastClaim = block.timestamp - lastClaimTimestamp[msg.sender];
        if (timeSinceLastClaim >= 24 hours) {
            return 0;
        }
        return 24 hours - timeSinceLastClaim;
    }

}