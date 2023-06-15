// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ZKTree.sol";

contract ZKTreeTest is ZKTree {
    constructor(uint32 levels, IHasher hasher, IVerifier verifier) ZKTree(levels, hasher, verifier) { }

    function commit(uint256 commitment) external {
        _commit(bytes32(commitment));
    }

    function nullify(
        uint256 nullifier,
        uint256 root,
        uint256[2] memory proofA,
        uint256[2][2] memory proofB,
        uint256[2] memory proofC
    ) external {
        _nullify(bytes32(nullifier), bytes32(root), proofA, proofB, proofC);
    }
}
