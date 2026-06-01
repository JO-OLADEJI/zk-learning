pragma circom 2.0.0;

template Quartic() {
    signal input x;
    signal input y;
    signal input z;
    signal input u;

    signal output r;
    signal v1;
    signal v2;

    v1 <== x * y;
    v2 <== z * u;
    r <== v1 * v2;

    // SOLUTION
    // witness vector = [1, r, x, y, z, u, v1, v2]
    //
    // Output         = [[0, 1, 0, 0, 0, 0, 0, 0],
    //                   [0, 0, 0, 0, 0, 0, 1, 0],
    //                   [0, 0, 0, 0, 0, 0, 0, 1]]
    //
    // Left           = [[0, 0, 0, 0, 0, 0, 1, 0],
    //                   [0, 0, 1, 0, 0, 0, 0, 0],
    //                   [0, 0, 0, 0, 1, 0, 0, 0]]
    //
    // Right          = [[0, 0, 0, 0, 0, 0, 0, 1],
    //                   [0, 0, 0, 1, 0, 0, 0, 0],
    //                   [0, 0, 0, 0, 0, 1, 0, 0]]
}

component main = Quartic();
