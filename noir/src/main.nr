use dep::std;

// This currently mimics the CommitmentHasher

struct Commitment {
    commitment: Field,
    nullifier_hash: Field
}

fn main(nullifier : Field, secret : Field) -> pub Commitment {
    let commitment_input = [nullifier, secret];
    let commitment_hash = std::hash::mimc_bn254(commitment_input);

    let nullifier_input = [nullifier];
    let nullifier_hash = std::hash::mimc_bn254(nullifier_input);

    Commitment {
        commitment: commitment_hash,
        nullifier_hash: nullifier_hash
    } 
}

#[test]
fn test_main() {
    let nullifier = 1;
    let secret = 2;
    let nullifier_input = [nullifier];
    constrain main(nullifier, secret).nullifier_hash == std::hash::mimc_bn254(nullifier_input);
    
    // Uncomment to make test fail
    // main(1, 1);
}
