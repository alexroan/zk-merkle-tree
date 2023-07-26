use dep::std;

// This currently mimics the CommitmentHasher

struct Commitment {
    commitment_hash: [u8; 32],
    nullifier_hash: [u8; 32]
}

fn hash_commitment(nullifier : [u8; 32], secret : [u8; 32]) -> pub Commitment {
    let commitment_input: [u8; 64] = [
        nullifier[0], nullifier[1], nullifier[2], nullifier[3], nullifier[4], nullifier[5], nullifier[6], nullifier[7],
        nullifier[8], nullifier[9], nullifier[10], nullifier[11], nullifier[12], nullifier[13], nullifier[14], nullifier[15],
        nullifier[16], nullifier[17], nullifier[18], nullifier[19], nullifier[20], nullifier[21], nullifier[22], nullifier[23],
        nullifier[24], nullifier[25], nullifier[26], nullifier[27], nullifier[28], nullifier[29], nullifier[30], nullifier[31],
        secret[0], secret[1], secret[2], secret[3], secret[4], secret[5], secret[6], secret[7],
        secret[8], secret[9], secret[10], secret[11], secret[12], secret[13], secret[14], secret[15],
        secret[16], secret[17], secret[18], secret[19], secret[20], secret[21], secret[22], secret[23],
        secret[24], secret[25], secret[26], secret[27], secret[28], secret[29], secret[30], secret[31]
    ];
    let commitment_hash = std::hash::sha256(commitment_input);
    std::println(commitment_hash);
    let nullifier_hash = std::hash::sha256(nullifier);

    Commitment {
        commitment_hash: commitment_hash,
        nullifier_hash: nullifier_hash
    }
}

#[test]
fn test_hash_commitment() {
    let nullifier = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
    let secret = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2];

    let expected_commitment_hash = [0xd6, 0xba, 0x93, 0x29, 0xf8, 0x93, 0x2c, 0x12, 0x19, 0x2b, 0x37, 0x84, 0x9f, 0x77, 0x21, 0x04, 0xd2, 0x, 0x48, 0xf7, 0x64, 0x34, 0xa3, 0x29, 0x05, 0x12, 0xd9, 0xd8, 0x14, 0xe4, 0x11, 0x6f];
    let commitment: Commitment = hash_commitment(nullifier, secret);
    assert(commitment.commitment_hash == expected_commitment_hash);

    let expected_nullifier_hash = std::hash::sha256(nullifier);
    assert(commitment.nullifier_hash == expected_nullifier_hash);
}

fn main(i_0: [u8; 32], i_1: [u8; 32]){
    let input : [u8; 64] = [
        i_0[0], i_0[1], i_0[2], i_0[3], i_0[4], i_0[5], i_0[6], i_0[7],
        i_0[8], i_0[9], i_0[10], i_0[11], i_0[12], i_0[13], i_0[14], i_0[15],
        i_0[16], i_0[17], i_0[18], i_0[19], i_0[20], i_0[21], i_0[22], i_0[23],
        i_0[24], i_0[25], i_0[26], i_0[27], i_0[28], i_0[29], i_0[30], i_0[31],
        i_1[0], i_1[1], i_1[2], i_1[3], i_1[4], i_1[5], i_1[6], i_1[7],
        i_1[8], i_1[9], i_1[10], i_1[11], i_1[12], i_1[13], i_1[14], i_1[15],
        i_1[16], i_1[17], i_1[18], i_1[19], i_1[20], i_1[21], i_1[22], i_1[23],
        i_1[24], i_1[25], i_1[26], i_1[27], i_1[28], i_1[29], i_1[30], i_1[31]
    ];
    let out = std::hash::sha256(input);
    std::println(out);
}