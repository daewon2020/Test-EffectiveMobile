//
//  CarouselCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import Foundation

protocol CarouselCollectionViewCellModelProtocol {
    var image: String { get }
}

final class CarouselCollectionViewCellModel: CarouselCollectionViewCellModelProtocol {
    var image: String
    
    init(image: String) {
        self.image = image
    }
}
