## Constrained State Machine Proof

A prover claims they ran a small 4-step state machine correctly and ended in a valid final state. They want to prove correctness without revealing the internal states.

The sequence is defined as:
\[
s_1 = s_0 \cdot k + 2
\]

\[
s_2 = s_1^2 - s_0
\]

\[
s_3 = s_2 - s_1 + k
\]

\[
s_4 = s_3 \cdot k + s_1
\]

The prover must also prove:

\[
s_2 \neq s_3
\]

You must encode this using standard R1CS-friendly techniques (no shortcuts like direct inequality primitives).
