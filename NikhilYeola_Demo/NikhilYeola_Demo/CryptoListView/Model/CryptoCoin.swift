//
//  CryptoCoin.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//


struct CryptoCoin: Codable {
    let name: String
    let symbol: String
    let type: String
    let isActive: Bool
    let isNew: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case type
        case isActive = "is_active"
        case isNew = "is_new"
    }
    
    func getImageName() -> String{
        if self.isActive{
            if self.type == "coin"{
                return "CryptoCoin"
            }else{
                return "CryptoToken"
            }
        }else{
            return "CryptoInactive"
        }
    }
}
