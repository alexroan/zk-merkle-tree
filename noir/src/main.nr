use dep::std;

// This currently mimics the CommitmentHasher

// struct Commitment {
//     commitment_hash: Field,
//     nullifier_hash: Field
// }

// fn main(nullifier : Field, secret : Field) -> pub Commitment {
//     let commitment_input = [nullifier, secret];
//     let commitment_hash = std::hash::pedersen(commitment_input)[0];

//     let nullifier_input = [nullifier];
//     let nullifier_hash = std::hash::pedersen(nullifier_input)[0];

//     Commitment {
//         commitment_hash: commitment_hash,
//         nullifier_hash: nullifier_hash
//     }
// }

// #[test]
// fn test_main() {
//     let nullifier = 1;
//     let secret = 2;
//     let nullifier_input = [nullifier];
//     assert(main(nullifier, secret).nullifier_hash == std::hash::pedersen(nullifier_input)[0]);
// }

fn main(input: [u8; 32]){
    let out = std::hash::sha256(input);
    std::println(out);

}