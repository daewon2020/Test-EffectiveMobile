//
//  CapacityCollectionViewCellModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 30.08.2022.
//

import Foundation

protocol CapacityCollectionViewCellModelProtocol: AnyObject {
    var capacity: String { get }
}

class CapacityCollectionViewCellModel: CapacityCollectionViewCellModelProtocol {
    var capacity: String
    
    init(capacity: String) {
        self.capacity = capacity
    }

}
