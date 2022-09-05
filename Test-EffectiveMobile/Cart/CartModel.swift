//
//  CartModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 02.09.2022.
//

import Foundation

struct CartModel: Decodable {
    var basket: [Basket]
    let id: String
    let delivery: String
    let total: Double
}

struct Basket: Decodable {
    let id: Int
    let images: String
    let price: Double
    let title: String
    var count: Int? = 1
}

