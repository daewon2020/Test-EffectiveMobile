//
//  ParamTabsCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import Foundation

protocol ParamTabsCollectionViewCellModelProtocol {
    var title: String { get }
}
                                                
class ParamTabsCollectionViewCellModel: ParamTabsCollectionViewCellModelProtocol {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
