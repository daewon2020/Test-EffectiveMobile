//
//  CategoryCollectionViewModel.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation

protocol CategoryCollectionViewModelProtocol: AnyObject {
    var name: String { get }
    var image: String { get }
    var isSelected: Bool { get set }
}

class CategoryCollectionViewModel: CategoryCollectionViewModelProtocol {
    var image: String {
        name.lowercased()
    }
    var name: String
    var isSelected: Bool
    
    init(name: String) {
        self.name = name
        isSelected = false
    }
}
