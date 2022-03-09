// Copyright 2022 Cartesi Pte. Ltd.

// SPDX-License-Identifier: Apache-2.0
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use
// this file except in compliance with the License. You may obtain a copy of the
// License at http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software distributed
// under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// @title Bank interface
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IBank {
    /// @notice returns the token used internally
    function getToken() external view returns (IERC20);

    /// @notice get balance of `_owner`
    /// @param _owner account owner
    function balanceOf(address _owner) external view returns (uint256);

    /// @notice transfer `_value` tokens from bank to `_to`
    /// @notice decrease the balance of caller by `_value`
    /// @param _to account that will receive `_value` tokens
    /// @param _value amount of tokens to be transfered
    function transfer(address _to, uint256 _value) external;

    /// @notice transfer `_value` tokens from caller to bank
    /// @notice increase the balance of `_to` by `_value`
    /// @dev you may need to call `token.approve(bank, _value)`
    /// @param _to account that will have their balance increased by `_value`
    /// @param _value amount of tokens to be transfered
    function deposit(address _to, uint256 _value) external;

    /// @notice `_value` tokens were transfered from the bank to `_to`
    /// @notice the balance of `_from` was decreased by `_value`
    /// @dev is triggered on any successful call to `transfer`
    /// @param _from the account/contract that called `transfer` and
    ///              got their balance decreased by `_value`
    /// @param _to the one that received `_value` tokens from the bank
    /// @param _value amount of tokens that were transfered
    event Transfer(address _from, address _to, uint256 _value);

    /// @notice `_value` tokens were transfered from `_from` to bank
    /// @notice the balance of `_to` was increased by `_value`
    /// @dev is triggered on any successful call to `deposit`
    /// @param _from the account/contract that called `deposit` and
    ///              transfered `_value` tokens to the bank
    /// @param _to the one that got their balance increased by `_value`
    /// @param _value amount of tokens that were transfered
    event Deposit(address _from, address _to, uint256 _value);
}
