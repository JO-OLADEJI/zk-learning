mod finite_fields;
mod rarecode;
mod bilinear_pairings;

use crate::bilinear_pairings::bn254;

fn main() {
    bn254::main();
}
