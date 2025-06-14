// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { console } from "forge-std/console.sol";

contract FLTToken is ERC20 {

    // address public owner;

    constructor() ERC20("FLTToken", "FLT") {}

    function mint(address to, uint256 amount) public {
        // require(msg.sender == owner, "Only owner can mint tokens");
        _mint(to, amount * 10 ** decimals());
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(amount > 0, "Transfer amount must be greater than zero");
        return super.transfer(to, amount * 10 ** decimals());
    }

    function approveFn(address spender, uint256 amount) public returns (bool) {
        require(amount > 0, "Approval amount must be greater than zero");
        return super.approve(spender, amount * 10 ** decimals());
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount * 10 ** decimals());
    }

    function totalSupply() public view override returns (uint256) {
        return super.totalSupply();
    }
}