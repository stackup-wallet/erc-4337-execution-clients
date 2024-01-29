# ERC-4337 Execution Clients

A repository for building Geth and other EVM execution clients with native ERC-4337 tracers.

## Pre-built docker images

Pre-built docker images are available at the following repositories. The tags correlate to the execution client's commit ref that the tracer was compiled with.

- [go-ethereum](https://hub.docker.com/repository/docker/stackupwallet/go-ethereum)
- [nitro](https://hub.docker.com/r/stackupwallet/nitro)

## Building binaries from source

Alternatively, you can build all binaries from source by cloning this repository.

### Git clone

Note that this repository uses git submodules to build execution clients based on a pinned release version. Make sure to include the `--recurse-submodules` flag in your git clone command.

```bash
git clone --recurse-submodules https://github.com/stackup-wallet/erc-4337-execution-client-builder.git
```

### Prerequisites

Most clients will require the following system dependencies to successfully compile:

- Go 1.20

### Running the build scripts

Use the following scripts to build a client from source with native ERC-4337 tracers included.

`$CLIENT` can be replaced with one of the currently supported execution clients:

- `go-ethereum`
- `bor` (Polygon PoS)
- `nitro` (Arbitrum)

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
