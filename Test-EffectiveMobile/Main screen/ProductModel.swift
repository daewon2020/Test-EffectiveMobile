//
//  ProductModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 27.08.2022.
//

import Foundation

struct ProductModel: Decodable {
    var homeStore: [Product]
    var bestSeller: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case homeStore = "home_store"
        case bestSeller = "best_seller"
    }
}

struct Product: Decodable {
    let id: Int
    let isNew: Bool?
    var isFavorites: Bool?
    let title: String
    let subtitle: String?
    let isBuy: Bool?
    let priceWithoutDiscount: Int?
    let discountPrice: Int?
    let picture: String
     
    private enum CodingKeys: String, CodingKey {
        case id
        case isNew = "is_new"
        case isFavorites = "is_favorites"
        case title
        case subtitle
        case isBuy = "is_bye"
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case picture
    }
}
