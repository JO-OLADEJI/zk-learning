pragma circom 2.0.0;

template Polynomial2() {
    signal input in[2];
    signal output out;

    signal v1;

    v1 <== in[0] * in[1];
    out <== (3 * in[0] * v1) + (5 * v1) + (-1 * in[0]) + (-2 * in[1]) + 3;

    // SOLUTION (computed by hand)
    // witness vector = [1, out, in[0], in[1], v1]
    //
    // Output         = [[0, 0, 0, 0, 1],
    //                  [-3, 1, 1, 2, -5]]
    //
    // Left           = [[0, 0, 1, 0, 0],
    //                   [0, 0, 3, 0, 0]]
    //
    // Right          = [[0, 0, 0, 1, 0],
    //                   [0, 0, 0, 0, 1]]

    // SOLUTION (computed by snarkjs - witness provided by me)
}

component main = Polynomial2();
