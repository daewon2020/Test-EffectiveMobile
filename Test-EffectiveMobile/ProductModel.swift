//
//  ProductModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 27.08.2022.
//

import Foundation

struct ProductModel: Decodable {
    let homeStore: [Product]
    let bestSeller: [Product]
}

struct Product: Decodable {
    let id: Int
    let isNew: Bool?
    let isFavorite: Bool?
    let title: String
    let subtitle: String?
    let isBye: Bool?
    let priceWithoutDiscount: Int?
    let discountPrice: Int?
    let picture: String
}
