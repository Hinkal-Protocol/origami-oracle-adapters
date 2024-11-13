// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;

interface IhTokenOracle {
    function exchangeRate() external view returns (uint256);
}
