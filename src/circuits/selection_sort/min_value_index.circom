pragma circom 2.1.6;

include "../array_swap/swap.circom";
include "../../../circomlib/circuits/comparators.circom";

template MinimumValueIndex(n) {
    assert(n > 0);

    signal input array[n];
    signal output index;

    signal rollingMinimum[n];
    signal rollingMinimumIndex[n];

    rollingMinimum[0] <== array[0];
    rollingMinimumIndex[0] <== 0;

    signal transitMul[n - 1];
    component minComparator[n];

    for (var i = 1; i < n; i++) {
        minComparator[i] = LessThan(252);
        minComparator[i].in <== [array[i], rollingMinimum[i - 1]];

        transitMul[i - 1] <== minComparator[i].out * array[i];
        rollingMinimum[i] <== (1 - minComparator[i].out) * rollingMinimum[i - 1] + transitMul[i - 1];
        rollingMinimumIndex[i] <== minComparator[i].out * i + (1 - minComparator[i].out) * rollingMinimumIndex[i - 1];
    }

    index <== rollingMinimumIndex[n - 1];
}
