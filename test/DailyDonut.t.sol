// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DailyDonut} from "../src/DailyDonut.sol";

contract DailyDonutTest is Test {
    DailyDonut public dailyDonut;

    function setUp() public {
        dailyDonut = new DailyDonut();
    }

    function test_claimDonut() public {
        dailyDonut.claimDonut();
        assertEq(dailyDonut._claimId(), 1);

        // expect to revert if claiming again before 24 hours over
        vm.expectRevert("You can only claim once every 24 hours");
        dailyDonut.claimDonut();

        // but another address can
        vm.startPrank(vm.addr(1));
        dailyDonut.claimDonut();
        assertEq(dailyDonut._claimId(), 2);
        vm.stopPrank();

        // in 24 hours can claim again
        vm.warp(24 hours + 1);

        dailyDonut.claimDonut();
        assertEq(dailyDonut._claimId(), 3);
    }

    
}
