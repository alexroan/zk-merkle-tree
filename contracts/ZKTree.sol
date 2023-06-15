// based on https://github.com/tornadocash/tornado-core/blob/master/contracts/Tornado.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./MerkleTreeWithHistory.sol";

interface IVerifier {
    function verifyProof(uint256[2] memory a, uint256[2][2] memory b, uint256[2] memory c, uint256[2] memory input)
        external
        pure
        returns (bool r);
}

contract ZKTree is MerkleTreeWithHistory {
    error CommitmentExists(bytes32 commitment);
    error NullifierAlreadySubmitted(bytes32 nullifier);
    error WrongMerkleRoot(bytes32 root);
    error InvalidProof();

    mapping(bytes32 => bool) public s_nullifiers;
    mapping(bytes32 => bool) public s_commitments;

    IVerifier public immutable i_verifier;

    event Commit(bytes32 indexed commitment, uint32 leafIndex, uint256 timestamp);

    constructor(uint32 levels, IHasher hasher, IVerifier verifier) MerkleTreeWithHistory(levels, hasher) {
        i_verifier = verifier;
    }

    function _commit(bytes32 commitment) internal {
        if (s_commitments[commitment]) revert CommitmentExists(commitment);

        s_commitments[commitment] = true;
        uint32 insertedIndex = _insert(commitment);
        emit Commit(commitment, insertedIndex, block.timestamp);
    }

    function _nullify(
        bytes32 nullifier,
        bytes32 root,
        uint256[2] memory proofA,
        uint256[2][2] memory proofB,
        uint256[2] memory proofC
    ) internal {
        if (s_nullifiers[nullifier]) revert NullifierAlreadySubmitted(nullifier);
        if (!isKnownRoot(root)) revert WrongMerkleRoot(root);
        if (!i_verifier.verifyProof(proofA, proofB, proofC, [uint256(nullifier), uint256(root)])) revert InvalidProof();

        s_nullifiers[nullifier] = true;
    }
}
