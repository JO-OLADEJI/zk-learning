pragma circom 2.0.0;

template Polynomial() {
    signal input x;
    signal input y;
    signal output z;

    signal v1;

    v1 <== x * x;
    z <== 2 * v1 + y;
    // a more efficient circuit will be `z <== 2 * x * x + y`
    // I chose a more verbose circuit for learning purposes

    // SOLUTION
    // witness vector = [1, z, x, y, v1]
    //
    // Output         = [[0, 0, 0, 0, 1],
    //                   [0, 1, 0, -1, 0]]
    //
    // Left           = [[0, 0, 1, 0, 0],
    //                   [0, 0, 0, 0, 2]]
    //
    // Right          = [[0, 0, 1, 0, 0],
    //                   [1, 0, 0, 0, 0]]
}

component main = Polynomial();
