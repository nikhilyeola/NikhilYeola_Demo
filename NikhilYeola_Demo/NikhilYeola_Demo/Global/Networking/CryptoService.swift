//
//  CryptoService.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//

import Foundation

class CryptoService {
    func fetchCryptoCoins(completion: @escaping (Result<[CryptoCoin], Error>) -> Void) {
        guard let url = URL(string: cryptoWebUrl) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Data"])))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([CryptoCoin].self, from: data)
                completion(.success(coins))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
