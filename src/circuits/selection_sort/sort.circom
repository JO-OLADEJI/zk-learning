pragma circom 2.1.6;

include "./min_value_index.circom";
include "../array_swap/swap.circom";
include "../../../circomlib/circuits/comparators.circom";

template SelectionSort(n) {
    signal input array[n];
    signal input sorted[n];

    component minIndexSelector[n - 1];
    component arraySwaps[n - 1];

    signal arrayTransition[n][n];
    arrayTransition[0] <== array;

    for (var i = 0; i < n - 1; i++) {
        minIndexSelector[i] = MinimumValueIndex(n - i);
        arraySwaps[i] = ArraySwap(n - i);

        // copy sorted values
        for (var copy = 0; copy < i; copy++) {
            arrayTransition[i + 1][copy] <== arrayTransition[i][copy];
        }

        // move unsorted values to min calculation circuit
        for (var j = i; j < n; j++) {
            minIndexSelector[i].array[j - i] <== arrayTransition[i][j];
            arraySwaps[i].base[j - i] <== arrayTransition[i][j];
        }
        arraySwaps[i].u <== 0;
        arraySwaps[i].v <== minIndexSelector[i].index;

        // copy sort-swapped sub-array
        for (var k = i; k < n; k++) {
            arrayTransition[i + 1][k] <== arraySwaps[i].swapped[k - i];
        }
    }

    sorted === arrayTransition[n - 1];
}

component main = SelectionSort(10);
