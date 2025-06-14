// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Counter {
    uint256 public num;
    uint256 public initialCount;

    constructor(uint256 _num) {
        num = _num;
        initialCount = _num;
    }

    function increase() public {
        num++;
    }

    function decrease() public {
        num--;
    }

    function reset() public {
        num = initialCount;
    }

}
