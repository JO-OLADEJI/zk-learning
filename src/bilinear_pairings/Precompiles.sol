// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Precompiles {
  // precompile - 0x06
  // https://www.evm.codes/precompiled?fork=osaka#0x06
  function ecAdd() external view returns (uint256, uint256) {
    assembly {
      let ptr := mload(0x40)
      let precompile:= 0x06

      // (x1, y1) = g1
      let x1 := 0x01
      let y1:= 0x02

      // (x2, y2) = g1 * 10
      let x2 := 0x09d3a257b99f1ad804a9e2354ea71c72da7fa518f4ca7904c6951d924b4045b4
      let y2 := 0x174be12ae3fd899d55d3e487fa103f951a24ca0f670ecae802209b2518ccca6c

      mstore(ptr, x1)
      mstore(add(ptr, 0x20), y1)
      mstore(add(ptr, 0x40), x2)
      mstore(add(ptr, 0x60), y2)

      if iszero(staticcall(gas(), precompile, ptr, 0x80, add(ptr, 0x80), 0x40)) {
        revert(0, 0)
      }

      return(add(ptr, 0x80), 0x40)
    }
  }
}
