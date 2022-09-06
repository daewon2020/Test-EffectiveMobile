//
//  ProductParamCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 30.08.2022.
//

import Foundation

protocol ProductParamCollectionViewCellModelProtocol: AnyObject {
    var title: String { get }
    var image: String { get }
}

final class ProductParamCollectionViewCellModel: ProductParamCollectionViewCellModelProtocol {
    var title: String
    var image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }

}
