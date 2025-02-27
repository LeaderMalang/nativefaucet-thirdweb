## Getting Started

You can start editing the page by modifying `contracts/NativeCurrencyFaucet.sol`.

This contract is designed as a **Native Currency Faucet** that allows users to request a fixed amount of native blockchain currency (e.g., ETH, BNB) with a cooldown period. Admins can manage requests, ban/unban users, and withdraw funds when needed.

## Features
- **Native Currency Distribution**: Users can request a small amount of native currency per request.
- **Cooldown Mechanism**: Prevents users from requesting too frequently.
- **Admin Controls**: Owners can ban/unban users and set request limits.
- **Funds Management**: Owners can withdraw or deposit native currency into the contract.

## Building the Project

After any changes to the contract, run:

```bash
npm run build
# or
yarn build
```

to compile your contracts. This will ensure the faucet contract is up to date.

## Deploying Contracts

When you're ready to deploy your contracts, just run one of the following commands:

```bash
npm run deploy
# or
yarn deploy
```

> [!IMPORTANT]
> This requires a secret key to make it work. Get your secret key [here](https://thirdweb.com/dashboard/settings/api-keys).
> Pass your secret key as a value after the `-k` flag.
> ```bash
> npm run deploy -- -k <your-secret-key>
> # or
> yarn deploy -k <your-secret-key>
> ```

## Releasing Contracts

If you want to release a version of your contracts publicly, you can use one of the following commands:

```bash
npm run release
# or
yarn release
```

## How It Works
1. **Users Request Native Currency**: Users call the `requestNativeCurrency()` function.
2. **Cooldown Applied**: The contract ensures they wait for the cooldown period before requesting again.
3. **Funds Are Sent from Contract Balance**: If the contract has enough balance, the requested amount is transferred.
4. **Admin Management**: The owner can ban/unban users, adjust cooldown settings, and withdraw native currency when needed.

## Managing the Faucet
- **Deposit Funds**: Simply send native currency to the contract address.
- **Withdraw Funds**: The owner can withdraw funds via `withdrawNativeCurrency()`.
- **Ban/Unban Users**: Use `banUser()` and `unbanUser()` functions.

For further details, check the contract file `contracts/NativeCurrencyFaucet.sol`.