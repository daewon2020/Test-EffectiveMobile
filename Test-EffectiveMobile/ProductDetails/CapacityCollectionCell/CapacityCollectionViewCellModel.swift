//
//  CapacityCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 30.08.2022.
//

import Foundation

protocol CapacityCollectionViewCellModelProtocol: AnyObject {
    var title: String { get }
}

class CapacityCollectionViewCellModel: CapacityCollectionViewCellModelProtocol {
    var title: String
    
    init(capacity: String) {
        self.title = capacity
    }

}
