//
//  DataManager.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation

struct DataManager {
    static var shared = DataManager()
    
    private init() {}
    
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
    
    func getparamTabs() -> [String]{
        ["Shop", "Details", "Features"]
    }
    
    func getBrands() -> [String]{
        ["Apple", "Xiaomi", "Huawei", "Samsung", "HONOR"]
    }
    
    func getPrice() -> [String]{
        ["$0-$499", "$500-$1000", "$1000-$1500", "$1500-$2000", "$>2000"]
    }
    
    func getSize() -> [String]{
        ["4.5-5.5", "5.6-7", "7-11", "11-15", "15-23"]
    }
}
