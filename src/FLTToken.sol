// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { console } from "forge-std/console.sol";

contract FLTToken is ERC20 {

    // address public owner;

    constructor() ERC20("FLTToken", "FLT") {}

    function mint(address to, uint256 amount) public {
        // require(msg.sender == owner, "Only owner can mint tokens");
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}