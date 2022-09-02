//
//  CartModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 02.09.2022.
//

import Foundation

struct CartModel: Decodable {
    let basket: [Basket]
    let id: Int
    let delivery: String
    let total: Double
}

struct Basket: Decodable {
    let id: Int
    let image: String
    let price: Double
    let title: String
}

