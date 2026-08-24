pragma circom 2.1.6;

template ExclusiveBranch(n) {
    assert(n > 0);
    signal input conditions[n];
    signal input values[n];
    signal output out;

    signal bitCheck[n];
    signal rollingSum[n];
    bitCheck[0] <== conditions[0];
    conditions[0] * conditions[0] === conditions[0];
    rollingSum[0] <== conditions[0] * values[0];

    for (var i = 1; i < n; i++) {
        conditions[i] * conditions[i] === conditions[i];
        bitCheck[i] <== bitCheck[i - 1] + conditions[i];
        rollingSum[i] <== rollingSum[i - 1] + conditions[i] * values[i];
    }

    bitCheck[n - 1] === 1;
    out <== rollingSum[n - 1];
}
