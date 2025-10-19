# aptos-curl

Download Aptos/Movement package source code directly from on-chain accounts.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/ThalaLabs/aptos-curl/main/install.sh | bash
```

This will download and install `aptos-curl` to `/usr/local/bin`.

## Usage

```bash
# Download package with source code available (Aave)
aptos-curl -a 0x39ddcd9e1a39fa14f25e3f9ec8a86074d05cc0881cbf667df8a6ee70942016fb -o ./aave-pool

# Download package without source code (will decompile)
aptos-curl -a 0x8b4a2c4bb53857c718a04c020b98f8c2e1f99a68b0f57389a8bf5434cd22e05c -o ./hyperion

# Download from Movement testnet
aptos-curl -a 0x1234... -o ./packages -n movement-testnet

# Force overwrite existing directory
aptos-curl -a 0x1234... -o ./packages -f

# Verbose output
aptos-curl -a 0x1234... -o ./packages -v
```

## Options

```
Usage: aptos-curl -a <ADDRESS> -o <OUTPUT_DIR> [OPTIONS]

Required:
    -a, --account <ADDRESS>    Account address to download packages from
    -o, --output <DIR>         Output directory for downloaded packages

Options:
    -n, --network <NETWORK>    Network to use (default: aptos-mainnet)
                               Options: aptos-mainnet, aptos-testnet, aptos-devnet,
                                        movement-mainnet, movement-testnet
    -f, --force                Overwrite existing output directory
    -v, --verbose              Show detailed output
    -h, --help                 Show this help message
    --version                  Show version information
```

## Features

- **Smart source detection**: Automatically downloads source code when available, decompiles bytecode when not
- **Multi-network support**: Works with Aptos and Movement networks (mainnet, testnet, devnet)
- **Clean output**: Minimal output by default, verbose mode available
- **Proper error handling**: Validates inputs and provides clear error messages
