use ark_ff::{Field, Fp64, MontBackend, MontConfig};

#[derive(MontConfig)]
#[modulus = "17"]
#[generator = "3"]
pub struct F17Config;

type F17 = Fp64<MontBackend<F17Config, 1>>;
type Poly = Vec<F17>; // p = 203

pub fn main() {
    // 1. get a fairly complex problem
    // 2. convert it to arithmetic circuits and wire it up in circom
    // 3. generate the witness for it using snarkjs
    // 4. generate a QAP for it using lagrange interpolation - plot the points used for the LI on a 2d graph
    // 5a. make sure tau is picked from a random integer
    // 5b. simulate a trusted setup and create a structured reference string - make assertions on the string via G2 to verify it's correctness using pairings
}
