pragma circom 2.1.6;

include "../../../circomlib/circuits/comparators.circom";
include "../../../circomlib/circuits/multiplexer.circom";

template ArraySelector(n, k) {
    signal input items[n];
    signal input indices[k];
    signal output values[k];

    component mux[k];
    component indexGuard[k];

    for (var i = 0; i < k; i++) {
        indexGuard[i] = LessThan(252);
        indexGuard[i].in <== [indices[i], n];
        indexGuard[i].out === 1;

        mux[i] = Multiplexer(1, n);
        mux[i].sel <== indices[i];

        for (var j = 0; j < n; j++) {
            mux[i].inp[j][0] <== items[j];
        }

        values[i] <== mux[i].out[0];
    }
}
