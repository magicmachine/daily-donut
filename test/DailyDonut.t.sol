// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DailyDonut} from "../src/DailyDonut.sol";

contract DailyDonutTest is Test {
    DailyDonut public dailyDonut;

    function setUp() public {
        dailyDonut = new DailyDonut();

        vm.warp(100 days);
    }

    function test_claimDonut() public {
        dailyDonut.claimDonut();
        assertEq(dailyDonut.claimId(), 1);
        assertEq(dailyDonut.timeUntilNextClaim(address(this)), 24 hours);

        // expect to revert if claiming again before 24 hours over
        vm.expectRevert("You can only claim once per day");
        dailyDonut.claimDonut();

        // but another address can
        vm.startPrank(vm.addr(1));
        assertEq(dailyDonut.timeUntilNextClaim(vm.addr(1)), 0);

        dailyDonut.claimDonut();
        assertEq(dailyDonut.claimId(), 2);
        vm.warp(block.timestamp + 10 seconds);
        assertEq(dailyDonut.timeUntilNextClaim(vm.addr(1)), 24 hours - 10 seconds);

        vm.expectRevert("You can only claim once per day");
        dailyDonut.claimDonut();

        vm.stopPrank();

        // in 24 hours can claim again
        vm.warp(block.timestamp + 24 hours);

        dailyDonut.claimDonut();
        assertEq(dailyDonut.claimId(), 3);
    }
}
