// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/test.sol";

contract NoirHasherTest is Test {

    function setUp() public {
        
    }

    function testSha256Hash() public {
        bytes memory number = abi.encode(0);
        console.logBytes(number);
        bytes32 hashed = sha256(number);
        console.logBytes32(hashed);
    }
}