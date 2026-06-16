pragma circom 2.1.6;

include "../../circomlib/circuits/comparators.circom";

template ArrayMin(n) {
    signal input in[n];
    signal input min;

    component EQ[n];
    component LTE[n];
    var eqAccumulator = 0;

    for (var i = 0; i < n; i++) {
        EQ[i] = IsEqual();
        EQ[i].in[0] <== min;
        EQ[i].in[1] <== in[i];
        eqAccumulator += EQ[i].out;

        LTE[i] = LessEqThan(32);
        LTE[i].in[0] <== min;
        LTE[i].in[1] <== in[i];
        LTE[i].out === 1;
    }

    signal excluded <== IsZero()(eqAccumulator);
    excluded === 0;
}

component main {public [min]} = ArrayMin(10);
