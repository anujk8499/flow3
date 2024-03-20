import NonFungibleToken from 0x09

pub contract CryptoPoops: NonFungibleToken {
  pub var totalSupply: UInt64

  pub event ContractInitialized()
  pub event Withdraw(id: UInt64, from: Address?)
  pub event Deposit(id: UInt64, to: Address?)

  pub resource NFT: NonFungibleToken.INFT {
    pub let id: UInt64

    pub let name: String
    pub let favouritePet: String
    pub let PureNumber: Int

    init(_name: String, _favouritePet: String, _PureNumber: Int) {
      self.id = self.uuid

      self.name = _name
      self.favouritePet = _favouritePet
      self.PureNumber = _PureNumber
    }
  }

  pub resource interface CollectionPublic {
        pub fun borrowAuthNFT(id: UInt64): &NFT
    }

  pub resource Collection: NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, CollectionPublic {
    pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

    pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
      let nft <- self.ownedNFTs.remove(key: withdrawID) 
            ?? panic("This NFT does not exist in this Collection.")
      emit Withdraw(id: nft.id, from: self.owner?.address)
      return <- nft
    }

    pub fun deposit(token: @NonFungibleToken.NFT) {
      let nft <- token as! @NFT
      emit Deposit(id: nft.id, to: self.owner?.address)
      self.ownedNFTs[nft.id] <-! nft
    }

    pub fun getIDs(): [UInt64] {
      return self.ownedNFTs.keys
    }

    pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
      return (&self.ownedNFTs[id] as &NonFungibleToken.NFT?)!
    }


    pub fun borrowAuthNFT(id: UInt64): &NFT {
        let ref = (&self.ownedNFTs[id] as auth &NonFungibleToken.NFT?) ?? panic("The NFT specified doesn't exist")

        return ref as! &NFT
    }


    init() {
      self.ownedNFTs <- {}
    }

    destroy() {
      destroy self.ownedNFTs
    }
  }

  pub fun createEmptyCollection(): @NonFungibleToken.Collection {
    return <- create Collection()
  }

  pub resource Minter {

    pub fun createNFT(name: String, favouritePet: String, PureNumber: Int): @NFT {
      return <- create NFT(_name: name, _favouritePet: favouritePet, _PureNumber: PureNumber)
    }

    access(contract)  fun createMinter(): @Minter {
      return <- create Minter()
    }

  }

  init() {
    self.totalSupply = 0
    emit ContractInitialized()
    self.account.save(<- create Minter(), to: /storage/Minter)
  }
}
