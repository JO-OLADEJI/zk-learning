// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { Precompiles } from "../src/bilinear_pairings/Precompiles.sol";

contract PrecompilesScript is Script {
    Precompiles public precompiles;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        precompiles = new Precompiles();
        (uint256 x3, uint256 y3) = precompiles.ecAdd();

        console.log("(x3, y3)");
        console.log(x3);
        console.log(y3);

        vm.stopBroadcast();
    }
}
