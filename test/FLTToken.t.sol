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

    function testMint() public {
        assertEq(t.balanceOf(address(this)), 50, "Initial supply should be 50 tokens");
        assertEq(t.balanceOf(address(0x1234)), 0, "OK");
    }

    function testTransfer() public {
        address addr = address(0x1234);
        t.transfer(addr, 15);
        assertEq(t.balanceOf(addr), 15, "OK");
        assertEq(t.balanceOf(address(this)), 35, "OK");

        vm.prank(addr);
        t.transfer(address(this), 10);
        assertEq(t.balanceOf(addr), 5, "OK");
        assertEq(t.balanceOf(address(this)), 45, "OK");
    }

    function testAprroveFn() public {        
        address addr = address(0x1234);

        t.approve(addr, 20);
        assertEq(t.allowance(address(this), addr), 20, "OK");

        vm.prank(addr);
        t.transferFrom(address(this), address(0x67890), 10);
        assertEq(t.balanceOf(address(0x67890)), 10, "0x67890 has 10 tokens left");
        assertEq(t.balanceOf(address(this)), 40, "this address has 40 tokens left");
    }

    function test_RevertWhen_InsuffAllow() public {

        address addr = address(0x1234);
        t.approve(addr, 10);

        vm.prank(addr);

        vm.expectRevert();
        t.transferFrom(address(this), address(0x67890), 20);
        assertEq(t.balanceOf(address(0x67890)), 0, "0x67890 should not have any tokens");
    }

    
}