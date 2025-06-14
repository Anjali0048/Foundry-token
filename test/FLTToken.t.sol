// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "src/FLTToken.sol";

contract TestFLTToken is Test {
    FLTToken t;

    function setUp() public {
        t = new FLTToken();
        t.mint(address(this), 50);
    }

    function amount(uint256 amt) public returns (uint256) {
        return amt * 10 ** t.decimals();
    }

    function testMint() public {
        assertEq(t.balanceOf(address(this)), amount(50), "Initial supply should be 50 tokens");
        assertEq(t.balanceOf(address(0x1234)), 0, "OK");
    }

    function testTransfer() public {
        address addr = address(0x1234);
        t.transfer(addr, 15);
        assertEq(t.balanceOf(addr), amount(15), "OK");
        assertEq(t.balanceOf(address(this)), amount(35), "OK");

        vm.prank(addr);
        t.transfer(address(this), 10);
        assertEq(t.balanceOf(addr), amount(5), "OK");
        assertEq(t.balanceOf(address(this)), amount(45), "OK");

    }

    function testAprroveFn() public {        
        address addr = address(0x1234);

        t.approveFn(addr, 20);
        assertEq(t.allowance(address(this), addr), amount(20), "OK");

        vm.prank(addr);
        t.transferFrom(address(this), address(0x67890), amount(10));
        assertEq(t.balanceOf(address(this)), amount(40), "OK");
        assertEq(t.balanceOf(address(0x67890)), amount(10), "OK");

    }
}