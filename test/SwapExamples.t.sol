// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2; // Enable ABI Encoder V2


import {Test, console2} from "forge-std/Test.sol";
import {SwapExamples} from "../src/SwapExamples.sol";
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';

contract SwapExamplesTest is Test {
    SwapExamples public swapExamples;

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    function setUp() public {
        vm.createSelectFork("mainnet", 17130166);
        swapExamples = new SwapExamples(ISwapRouter(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45));
    }

    function test_Increment() public {
         deal(DAI, address(this), 1e50);

        uint256 amountOut = 1 ether; // Amount of WETH9 we want to receive
        uint256 amountInMaximum = 10000000000 ether; // Maximum amount of DAI we're willing to spend

        TransferHelper.safeApprove(DAI, address(swapExamples), 1e50 );
        // Perform the swap
        uint256 amountInActual = swapExamples.swapExactOutputSingle(amountOut, amountInMaximum);
    }
}
