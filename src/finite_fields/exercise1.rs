use ark_bn254::{Fr as ScalarField, G1Projective as G};
use ark_ec::PrimeGroup;

pub fn main() {
    let g = G::generator();
    let inverse = -g;

    println!("G: {}", g);
    println!("G_inv: {}", inverse);
    println!("G + G_inv: {}", g + inverse);
}
