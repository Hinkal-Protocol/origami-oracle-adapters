// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.20;

import {IMinimalAggregatorV3Interface} from "src/interfaces/IMinimalAggregatorV3Interface.sol";
import {IhTokenOracle} from "src/interfaces/hinkal/IhTokenOracle.sol";

/// @title HEthToEthExchangeRateAdapter
/// @author Hinkal
/// @custom:contact https://hinkal.pro
/// @notice hETH/ETH exchange rate price feed.
/// @dev This contract should only be deployed on Ethereum.
contract HEthToEthExchangeRateAdapter is IMinimalAggregatorV3Interface {
    /// @inheritdoc IMinimalAggregatorV3Interface
    // @dev The calculated price has 18 decimals precision, whatever the value of `decimals`.
    uint8 public constant override decimals = 18;

    /// @notice The description of the price feed.
    string public constant description = "hETH/ETH exchange rate";

    /// @notice The address of the hTokenOracle in Ethereum
    IhTokenOracle public constant HTOKEN_ORACLE =
        IhTokenOracle(0x0Bc5D46b202EfCaAed5b8cf10bDBBA9E036CCf53);

    /// @inheritdoc IMinimalAggregatorV3Interface
    /// @dev Returns zero for roundId, startedAt, updatedAt and answeredInRound.
    function latestRoundData()
        external
        view
        override
        returns (uint80, int256, uint256, uint256, uint80)
    {
        return (0, int256(HTOKEN_ORACLE.exchangeRate()), 0, 0, 0);
    }
}
