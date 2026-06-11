pragma circom 2.2.0;

template StateMachine() {
    signal input in;
    signal input out;
    signal s1;
    signal s2;
    signal s3;

    // the public constant `k` is `keccak256("state_machine")`
    // 0xd794dd2a2d0b9c45febdcb5da6fc8ea4ce2e9b217096fd4e58125591b1d0afb5
    var k = 97510282233993704500285788360092094989126004296435026816552952672367735254965;

    s1 <== in * k + 2;
    s2 <== s1 * s1 - in;
    s3 <== s2 - s1 + k;
    out === s3 * k + s1;

    // constrain s2 != s3
    component neq = IsZero();

    neq.in <== s2 - s3;
    0 === neq.out;
}

template IsZero() {
    signal input in;
    signal output out;

    signal inverse;

    inverse <-- in == 0 ? 0 : 1 / in;

    out <== 1 - (in * inverse);
    0 === in * out;
}

component main{ public [out] } = StateMachine();
