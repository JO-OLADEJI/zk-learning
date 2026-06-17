pragma circom 2.1.4;

include "../../circomlib/circuits/comparators.circom";
include "../../circomlib/circuits/multiplexer.circom";

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed.

template Pow() {
    signal input a[2];
    signal output c;

    // constrain the power to < 32
    signal powerCheck <== LessThan(8)([a[1], 32]);
    powerCheck === 1;

    // constrain out to the the quin selector of index a[1]
    component MUX = Multiplexer(1, 32);
    MUX.sel <== a[1];

    // calculate n[0] to the (--32)th power
    signal powers[32];

    powers[0] <== 1;
    MUX.inp[0][0] <== powers[0];

    for (var i = 1; i < 32; i++) {
        powers[i] <== powers[i - 1] * a[0];
        MUX.inp[i][0] <== powers[i];
    }

    c <== MUX.out[0];
}

component main = Pow();
