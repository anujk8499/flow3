import CryptoPoops from 0x09
import NonFungibleToken from 0x09

transaction(recipient: Address, name: String, favouritePet: String, PureNumber: Int) {

  prepare(signer: AuthAccount) {
    let minter = signer.borrow<&CryptoPoops.Minter>(from: /storage/Minter)
                    ?? panic("This signer is not the one who deployed the contract.")


    let recipientsCollection = getAccount(recipient).getCapability(/public/MyCollection)
                                  .borrow<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>()
                                  ?? panic("The recipient does not have a Collection.")

    let nft <- minter.createNFT(name: name, favouritePet: favouritePet, PureNumber: PureNumber)

    recipientsCollection.deposit(token: <- nft)

    log("mint successfully")
  }

}
