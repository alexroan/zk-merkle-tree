// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/test.sol";

contract NoirHasherTest is Test {

    function setUp() public {
    }

    function test_sha256One() public {
        bytes memory number = abi.encode(0);
        console.logBytes(number);
        bytes32 hashed = sha256(number);
        console.logBytes32(hashed);
    }

    function test_sha256Two() public {
        bytes memory number0 = abi.encode(0);
        bytes memory number1 = abi.encode(1);
        bytes memory combined = bytes.concat(number0, number1);
        console.logBytes(combined);
        bytes32 hashed = sha256(combined);
        console.logBytes32(hashed);
    }
}