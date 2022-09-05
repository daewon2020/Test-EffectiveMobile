//
//  ProductDetailsModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import Foundation

struct ProductDetailsModel: Decodable {
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int64
    let rating: Double
    let sd: String
    let ssd: String
    let title: String
}
