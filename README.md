# ERC-4337 Execution Client Builder

A repository for building Geth and other EVM execution clients with native ERC-4337 tracers.

## Git Clone

The repository uses git submodules to build execution clients from source at a pinned release version. Make sure to include the `--recurse-submodules` flag in your git clone command.

## Prerequisites

- Go 1.20 or later
- Docker

## Building binaries from source

Use the following scripts to build a client from source with native ERC-4337 tracers included.

`$CLIENT` can be replaced with one of the currently supported clients:

- `go-ethereum`

```bash
$ ./build_scripts/$CLIENT.sh
```

**All binaries will be available in `./builds/$CLIENT` directory.**

## License

Distributed under the GPL-3.0 License. See [LICENSE](./LICENSE) for more information.

## Contact

Feel free to direct any technical related questions to the `dev-hub` channel in the [Stackup Discord](https://discord.gg/VTjJGvMNyW).
