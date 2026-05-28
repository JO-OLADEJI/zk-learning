// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Precompiles {
    // precompile - 0x06
    // https://www.evm.codes/precompiled?fork=osaka#0x06
    function ecAdd() external view returns (uint256, uint256) {
        assembly {
            let ptr := mload(0x40)
            let precompile := 0x06

            // (x1, y1) = g1
            let x1 := 0x01
            let y1 := 0x02

            // (x2, y2) = g1 * 10
            let
                x2
            := 0x09d3a257b99f1ad804a9e2354ea71c72da7fa518f4ca7904c6951d924b4045b4
            let
                y2
            := 0x174be12ae3fd899d55d3e487fa103f951a24ca0f670ecae802209b2518ccca6c

            mstore(ptr, x1)
            mstore(add(ptr, 0x20), y1)
            mstore(add(ptr, 0x40), x2)
            mstore(add(ptr, 0x60), y2)

            if iszero(
                staticcall(
                    gas(),
                    precompile,
                    ptr,
                    mul(0x20, 4),
                    add(ptr, 0x80),
                    0x40
                )
            ) {
                revert(0, 0)
            }

            return(add(ptr, 0x80), 0x40)
        }
    }

    // precompile - 0x08
    // https://www.evm.codes/precompiled?fork=osaka#0x08
    function ecPairing() external view returns (bool) {
        assembly {
            // given a=4, b=3, c=6, d=2;
            // (x1, y1) = g1 * -a (a inverse)
            let
                x1
            := 0x06a7b64af8f414bcbeef455b1da5208c9b592b83ee6599824caa6d2ee9141a76
            let
                y1
            := 0x277d002f54436e7da803601aec9cf8740ce99198c18a74286d979cbc9695cd8b

            // (x2, y2) = g2 * b
            let
                x2_i
            := 0x1014772f57bb9742735191cd5dcfe4ebbc04156b6878a0a7c9824f32ffb66e85
            let
                x2_j
            := 0x06064e784db10e9051e52826e192715e8d7e478cb09a5e0012defa0694fbc7f5
            let
                y2_i
            := 0x021e2335f3354bb7922ffcc2f38d3323dd9453ac49b55441452aeaca147711b2
            let
                y2_j
            := 0x058e1d5681b5b9e0074b0f9c8d2c68a069b920d74521e79765036d57666c5597

            // (x3, y3) = g1 * c
            let
                x3
            := 0x09f4ca411a3f52f4e0792fd9e792779856719215d3b32a762afe3d5b8c684af9
            let
                y3
            := 0x0d8ef3d795acd4b35d4366ab22e4ad335273aa59429e26929d0f64583474d9c8

            // (x4, y4) = g2 * d
            let
                x4_i
            := 0x203e205db4f19b37b60121b83a7333706db86431c6d835849957ed8c3928ad79
            let
                x4_j
            := 0x27dc7234fd11d3e8c36c59277c3e6f149d5cd3cfa9a62aee49f8130962b4b3b9
            let
                y4_i
            := 0x195e8aa5b7827463722b8c153931579d3505566b4edf48d498e185f0509de152
            let
                y4_j
            := 0x04bb53b8977e5f92a0bc372742c4830944a59b4fe6b1c0466e2a6dad122b5d2e

            /* we want to prove that a•b = c•d ("•" here represents bilinear pairing)
             * which means -a•b + c•d === 0
             * using `e` to rep. bilinear pairing function;
             * e(-aG_1, bG_2) + e(cG_1, dG_2) === 0
             * in the same fasion, the following should hold `true` as well
             * - e(aG_1, -bG_2) + e(cG_1, dG_2) === 0
             * - e(aG_1, bG_2) + e(-cG_1, dG_2) === 0
             * - e(aG_1, bG_2) + e(cG_1, -dG_2) === 0
             */

            let ptr := mload(0x40)

            mstore(ptr, x1)
            mstore(add(ptr, 0x20), y1)

            mstore(add(ptr, 0x40), x2_i)
            mstore(add(ptr, 0x60), x2_j)
            mstore(add(ptr, 0x80), y2_i)
            mstore(add(ptr, 0xa0), y2_j)

            mstore(add(ptr, 0xc0), x3)
            mstore(add(ptr, 0xe0), y3)

            mstore(add(ptr, 0x100), x4_i)
            mstore(add(ptr, 0x120), x4_j)
            mstore(add(ptr, 0x140), y4_i)
            mstore(add(ptr, 0x160), y4_j)

            if iszero(
                staticcall(
                    gas(),
                    0x08,
                    ptr,
                    mul(0x20, 12),
                    add(ptr, 0x180),
                    0x20
                )
            ) {
                revert(0, 0) // call didn't execute successfully
            }

            // 0 - proof is invalid
            // 1 - proof is valid
            return(add(ptr, 0x180), returndatasize())
        }
    }
}
