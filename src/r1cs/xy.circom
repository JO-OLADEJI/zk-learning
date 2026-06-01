pragma circom 2.0.0;

template XY() {
    signal input x;
    signal input y;
    signal output z;

    z <== x * y;
}

component main = XY();
