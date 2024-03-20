# CryptoPoops

CryptoPoops is a blockchain smart contract written in Move, based on the 0x09 standard for Non-Fungible Tokens (NFTs). It allows users to create, deposit, withdraw, and manage non-fungible tokens representing unique digital assets.

## Overview

This contract implements the NonFungibleToken standard from version 0x09 and extends it to include additional functionalities specific to CryptoPoops. It provides mechanisms for minting new tokens, depositing tokens into collections, withdrawing tokens from collections, and more.

## Features

- **NFT Creation**: Users can create new non-fungible tokens with unique attributes such as name, favorite pet, and a pure number.
- **Collection Management**: Users can create collections to store their NFTs and perform operations like depositing and withdrawing tokens.

## Usage

### Creating a Collection

To create an empty collection, call the `createEmptyCollection` function.

### Creating a NFt
To create an NFT we need to call the `createNFt` function.
