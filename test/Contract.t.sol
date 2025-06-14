// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Contract.sol";

contract TestContract is Test {
    Counter c;

    function setUp() public {
        c = new Counter(1);
    }

    function testIncrease() public {
        c.increase();
        assertEq(c.num(), 2, "Count should be 2 after increase");
    }
    function testDecrease() public {
        c.increase();
        c.decrease();
        assertEq(c.num(), 1, "Count should be 1 after increase and decrease");
    }
    function testReset() public {
        c.increase();
        c.reset();
        assertEq(c.num(), 1, "Count should be 1 after reset");
    }
    function test_Revert_Decrease() public {
        // vm.expectRevert();
        vm.expectRevert(stdError.arithmeticError);
        c.decrease();
        c.decrease();
        c.decrease();
        c.decrease();
        c.decrease();
        // assertEq(c.num(), 0, "Count should be 0 after decrease");
    }

}
