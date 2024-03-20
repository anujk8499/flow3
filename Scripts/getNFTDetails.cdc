import CryptoPoops from 0x09
import NonFungibleToken from 0x09

pub fun main(index: UInt64,User: Address) {

    let recipientsCollection = getAccount(User).getCapability(/public/MyCollection)
                                  .borrow<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>()
                                  ?? panic("The recipient does not have a Collection.")

    var NFT = recipientsCollection.borrowAuthNFT(id: index)

    log( NFT.name)  ;
    log( NFT.favouritePet) ; 
    log( NFT.PureNumber) ; 
}
