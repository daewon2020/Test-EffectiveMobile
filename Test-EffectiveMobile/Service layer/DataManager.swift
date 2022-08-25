//
//  DataManager.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation

struct DataManager {
    func getCategories() -> [CategoryCollectionViewModelProtocol] {
        [
            CategoryCollectionViewModel(name: "Phones"),
            CategoryCollectionViewModel(name: "Computer"),
            CategoryCollectionViewModel(name: "Health"),
            CategoryCollectionViewModel(name: "Books"),
            CategoryCollectionViewModel(name: "TV"),
            CategoryCollectionViewModel(name: "Games")
        ]
    }
}
