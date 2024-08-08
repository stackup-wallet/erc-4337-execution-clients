![](https://i.imgur.com/WyRwN0y.png)

# Getting started

A repository for building Geth and other EVM execution clients with native ERC-4337 tracers.

## Execution client status

| Client                    | Release version | Pre-built docker image | Build binary from source |
| ------------------------- | --------------- | ---------------------- | ------------------------ |
| go-ethereum               | `v1.13.15`      | ✅                     | ✅                       |
| bor (Polygon PoS)         | `v1.3.4`        | ❌                     | ✅                       |
| nitro (Arbitrum)          | `v3.1.0`        | ✅                     | ❌                       |
| op-geth (Optimism)        | `v1.101315.3`   | ✅                     | ❌                       |
| base-node (Base)          | `v0.10.0`       | ✅                     | ❌                       |
| bsc (Binance Smart Chain) | `v1.4.11`       | ❌                     | ✅                       |
| avalanchego (Avax)        | `v1.11.8`       | ❌                     | ✅                       |

## Pre-built docker images

Pre-built docker images are available at the following repositories. The tags correlate to the execution client's commit ref that the tracer was compiled with.

- [go-ethereum](https://hub.docker.com/r/stackupwallet/go-ethereum/tags)
- [nitro](https://hub.docker.com/r/stackupwallet/nitro/tags)
- [op-geth](https://hub.docker.com/r/stackupwallet/op-geth/tags)
- [base-node](https://hub.docker.com/r/stackupwallet/base-node/tags)

## Building binaries from source

Alternatively, you can build all binaries from source by cloning this repository.

### Git clone

Note that this repository uses git submodules to build execution clients based on a pinned release version. Make sure to include the `--recurse-submodules` flag in your git clone command.

```bash
git clone --recurse-submodules https://github.com/stackup-wallet/erc-4337-execution-client-builder.git
```

### Prerequisites

Most clients will require the following system dependencies to successfully compile:

- Go 1.21

### Running the build scripts

Use the following scripts to build a client from source with native ERC-4337 tracers included.

`$CLIENT` can be replaced with one of the currently supported execution clients:

- `go-ethereum`
- `bor`
- `nitro`
- `op-geth`
- `base-node`
- `bsc`
- `avalanchego`

```bash
./build_scripts/$CLIENT.sh
```

**All binaries will be available in the `./builds/$CLIENT` directory.**

## Tracer development

See the documentation on [Geth's custom EVM tracers](https://geth.ethereum.org/docs/developers/evm-tracing/custom-tracer) for details on setting up a dev environment for tracer iterations.

## License

Distributed under the GPL-3.0 License. See [LICENSE](./LICENSE) for more information.

## Contact

Feel free to direct any technical related questions to the `dev-hub` channel in the [Stackup Discord](https://discord.gg/VTjJGvMNyW).
