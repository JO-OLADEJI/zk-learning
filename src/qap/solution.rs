use ark_bn254::{Fr, FrConfig};
use ark_ff::{PrimeField, Fp, MontBackend};

const CONSTANT: &str = "0xd794dd2a2d0b9c45febdcb5da6fc8ea4ce2e9b217096fd4e58125591b1d0afb5"; // keccak256("state_machine")

pub fn main() {
    let input: u64 = 5;
    let out = compute(input);
    println!("out signal: {}", out);
}

fn compute(input: u64) -> Fp<MontBackend<FrConfig, 4>, 4> {
    let constant = CONSTANT.strip_prefix("0x").unwrap();
    let res = hex::decode(constant).expect("hex::decode failed");
    let mut byte_array: [u8; 32] = [0; 32];
    byte_array.copy_from_slice(&res);

    let k = Fr::from_be_bytes_mod_order(&byte_array);

    let s0 = Fr::from(input);
    let s1 = s0 * k + Fr::from(2);
    let s2 = s1 * s1 - s0;
    let s3 = s2 - s1 + k;
    let out = s3 * k + s1;

    out
}
