use ark_bn254::{Bn254, Fr, G1Projective, G2Projective};
use ark_ec::{PrimeGroup, pairing::Pairing};

pub fn main() {
    if example1() {
        println!("Pairings are equal!");
    }

    if example2() {
        println!("multiplicative pairings are equal");
    }
}

fn example1() -> bool {
    // generators
    let g1 = G1Projective::generator();
    let g2 = G2Projective::generator();

    // scalars
    let a = Fr::from(3);
    let b = Fr::from(8);
    let c = a * b;

    // points
    let p = g1 * a;
    let q = g2 * b;
    let r = g1 * c;

    // pairings
    let e1 = Bn254::pairing(p, q);
    let e2 = Bn254::pairing(r, g2);

    e1 == e2
}

fn example2() -> bool {
    // generators
    let g1 = G1Projective::generator();
    let g2 = G2Projective::generator();

    // scalars
    let ab_scalars = (Fr::from(2), Fr::from(3));
    let pq_scalars = (Fr::from(4), Fr::from(5));
    let scalar_products = (ab_scalars.0 * ab_scalars.1) + (pq_scalars.0 * pq_scalars.1);

    let xy_scalars = (Fr::from(2), Fr::from(13));
    assert_eq!(xy_scalars.0 * xy_scalars.1, scalar_products);

    // points
    let ab = (g1 * ab_scalars.0, g2 * ab_scalars.1);
    let pq = (g1 * pq_scalars.0, g2 * pq_scalars.1);
    let xy = (g1 * xy_scalars.0, g2 * xy_scalars.1);

    // pairings
    let e1 = Bn254::pairing(ab.0, ab.1);
    let e2 = Bn254::pairing(pq.0, pq.1);
    let e3 = Bn254::pairing(xy.0, xy.1);

    e1 + e2 == e3
}
