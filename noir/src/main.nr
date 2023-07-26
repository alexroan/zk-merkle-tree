use dep::std;

////////////////
// HashLeftRight
////////////////
fn hash_left_right(left : [u8; 32], right : [u8; 32]) -> [u8; 32] {
    let input: [u8; 64] = [
        left[0], left[1], left[2], left[3], left[4], left[5], left[6], left[7],
        left[8], left[9], left[10], left[11], left[12], left[13], left[14], left[15],
        left[16], left[17], left[18], left[19], left[20], left[21], left[22], left[23],
        left[24], left[25], left[26], left[27], left[28], left[29], left[30], left[31],
        right[0], right[1], right[2], right[3], right[4], right[5], right[6], right[7],
        right[8], right[9], right[10], right[11], right[12], right[13], right[14], right[15],
        right[16], right[17], right[18], right[19], right[20], right[21], right[22], right[23],
        right[24], right[25], right[26], right[27], right[28], right[29], right[30], right[31]
    ];
    let output = std::hash::sha256(input);
    output
}

#[test]
fn test_has_left_right() {
    let left = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
    let right = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2];
    let expected_output = [0xd6, 0xba, 0x93, 0x29, 0xf8, 0x93, 0x2c, 0x12, 0x19, 0x2b, 0x37, 0x84, 0x9f, 0x77, 0x21, 0x04, 0xd2, 0x, 0x48, 0xf7, 0x64, 0x34, 0xa3, 0x29, 0x05, 0x12, 0xd9, 0xd8, 0x14, 0xe4, 0x11, 0x6f];
    let output = hash_left_right(left, right);
    assert(output == expected_output);
}

///////////////////
// CommitmentHasher
///////////////////
struct Commitment {
    commitment_hash: [u8; 32],
    nullifier_hash: [u8; 32]
}

fn hash_commitment(nullifier : [u8; 32], secret : [u8; 32]) -> pub Commitment {
    let commitment_hash = hash_left_right(nullifier, secret);
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

//////////////////////////
// Compute the Merkle Root
//////////////////////////

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