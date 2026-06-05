pragma circom 2.0.0;

template IsNonZero() {
    // challenge - `out` should be `0` when `in` is `0`
    //           - `out` should be `1` when `in` is {{non-zero}}

    signal input in;
    signal output out;

    signal inv;

    inv <-- in == 0 ? 0 : 1/in;

    out <== in * inv;
    0 === in * (out - 1);
}

component main = IsNonZero();
