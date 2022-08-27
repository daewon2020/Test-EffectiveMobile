//
//  NetworkManager.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation


class NetworkManager {
    static var shared = NetworkManager()
    
    init() {}
    
    func fetchProducts(with url: String, comletion: @escaping (ProductModel) -> Void) {
        guard let url = URL(string: url) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Fetch data error")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let products = try decoder.decode(ProductModel.self, from: data)
                DispatchQueue.main.async {
                    comletion(products)
                }
            } catch {
                print("JSON error")
            }
        }.resume()
    }
}
