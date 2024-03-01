




interface IVRF {
    function lastRequestId() external view returns(uint);
    function requestRandomWords()
        external
        returns (uint256 requestId);
}

// SPDX-License-Identifier: MIT
pragma solidity ^*;