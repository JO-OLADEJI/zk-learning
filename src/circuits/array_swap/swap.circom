pragma circom 2.1.6;

include "./array_selector.circom";
include "./exclusive_branch.circom";
include "../../../circomlib/circuits/gates.circom";
include "../../../circomlib/circuits/comparators.circom";

template ArraySwap(n) {
    signal input base[n];
    signal input u;
    signal input v;
    signal output swapped[n];

    component baseSelector = ArraySelector(n, 2);
    baseSelector.indices[0] <== u;
    baseSelector.indices[1] <== v;

    for (var i = 0; i < n; i++) {
        baseSelector.items[i] <== base[i];
    }

    signal uItem <== baseSelector.values[0];
    signal vItem <== baseSelector.values[1];
    signal uEqualsV <== IsEqual()([u, v]);

    component uEQ[n];
    component vEQ[n];
    component neitherUV[n];
    component conditionals[n];
    component shouldSubtractDuplicates[n]; // when u === v

    for (var i = 0; i < n; i++) {
        uEQ[i] = IsEqual();
        uEQ[i].in[0] <== u;
        uEQ[i].in[1] <== i;

        vEQ[i] = IsEqual();
        vEQ[i].in[0] <== v;
        vEQ[i].in[1] <== i;

        neitherUV[i] = IsZero();
        neitherUV[i].in <== uEQ[i].out + vEQ[i].out;

        shouldSubtractDuplicates[i] = AND();
        shouldSubtractDuplicates[i].a <== uEqualsV;
        shouldSubtractDuplicates[i].b <== uEQ[i].out;

        conditionals[i] = ExclusiveBranch(3);
        conditionals[i].conditions <== [
            uEQ[i].out - shouldSubtractDuplicates[i].out,
            vEQ[i].out,
            neitherUV[i].out
        ];
        conditionals[i].values <== [vItem, uItem, base[i]];

        swapped[i] <== conditionals[i].out;
    }
}

// component main = ArraySwap(10);
