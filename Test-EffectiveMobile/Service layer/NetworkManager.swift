//
//  NetworkManager.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation


final class NetworkManager {
    static var shared = NetworkManager()
    
    init() {}

    func fetchImage(with url: String, comletion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                print("Fetch data error")
                return
            }
            
            DispatchQueue.main.async {
                comletion(data)
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(with url: String, for model: T.Type, comletion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("recieve data error: \(error?.localizedDescription ?? "")")
                return
            }
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    comletion(data)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
