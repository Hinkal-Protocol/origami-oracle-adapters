// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import {OrigamiTest} from "../OrigamiTest.sol";
import {HEthToEthExchangeRateAdapter} from "src/exchange-rate-adapters/HEthToEthExchangeRateAdapter.sol";
import {IhTokenOracle} from "src/interfaces/hinkal/IhTokenOracle.sol";

contract HEthToEthExchangeRateAdapterTest is OrigamiTest {
    HEthToEthExchangeRateAdapter internal adapter;
    IhTokenOracle internal hTokenOracle;

    function setUp() public {
        fork("mainnet", 21_179_206);
        adapter = new HEthToEthExchangeRateAdapter();
        hTokenOracle = IhTokenOracle(
            0x0Bc5D46b202EfCaAed5b8cf10bDBBA9E036CCf53
        );
    }

    function test_decimals() public view {
        assertEq(adapter.decimals(), uint8(18));
    }

    function test_description() public view {
        assertEq(adapter.description(), "hETH/ETH exchange rate");
    }

    function test_latestRoundData() public view {
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = adapter.latestRoundData();
        assertEq(roundId, 0);
        assertEq(uint256(answer), hTokenOracle.exchangeRate());
        assertEq(answer, 1000750825427558219); // Exchange rate queried at block 21179206
        assertEq(startedAt, 0);
        assertEq(updatedAt, 0);
        assertEq(answeredInRound, 0);
    }
}
