### Ronin Testnet (Saigon)

Deploy: `forge create src/DailyDonut.sol:DailyDonut --legacy --rpc-url https://saigon-testnet.roninchain.com/rpc --private-key $PRIVATE_KEY `
Verify: `forge verify-contract --verifier sourcify --verifier-url https://sourcify.roninchain.com/server/ --chain-id 2021 <ADDRESS> src/DailyDonut.sol:DailyDonut`

### Ronin Prod

Deploy: `forge create src/DailyDonut.sol:DailyDonut --legacy --rpc-url https://api.roninchain.com/rpc --private-key $PRIVATE_KEY`
Verify: `forge verify-contract --verifier sourcify --verifier-url https://sourcify.roninchain.com/server/ --chain-id 2020 <ADDRESS> src/DailyDonut.sol:DailyDonut`


### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
