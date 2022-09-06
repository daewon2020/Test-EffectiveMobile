//
//  ColorCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 29.08.2022.
//

import Foundation

protocol ColorCollectionViewCellModelProtocol: AnyObject {
    var color: String { get }
}

final class ColorCollectionViewCellModel: ColorCollectionViewCellModelProtocol {
    var color: String
    
    init(color: String) {
        self.color = color
    }

}
