pragma circom 2.1.6;

/*
 * Write a Circom function that finds the root of a degree 2 polynomial using the quadratic formula.
 * Remember, everything is done over a finite field, so you need to use the modular square root
 * from the first example.
 * Then, write constraints that the two roots (if they exist) satisfy the polynomial.
 * Pass in the polynomial to the Circom template as an array of three coefficients.
 */

template QuadraticRoots() {
    // ax² + bx + c
    signal input in[3];
    signal input out[2];

    // verify the sum and product of roots
    signal aInv <-- 1 / in[0];
    signal rootsProduct <== out[0] * out[1];
    signal rootsSum <== out[0] + out[1];

    1 === in[0] * aInv;
    rootsSum === -1 * in[1] * aInv;
    rootsProduct === in[2] * aInv;
}

component main {public [out]} = QuadraticRoots();
