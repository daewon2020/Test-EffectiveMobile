//
//  MainScreenPresenter.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func collectionCellDidTapped(at indexPath: IndexPath)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    private unowned var view: MainScreenVCProtocol
    private var categories = [CategoryCollectionViewModelProtocol]()
    
    init(view: MainScreenVCProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        LocationManager.shared.bindLocation { location in
            if let location = location {
                self.view.setLocation(location)
            } else {
                self.view.setLocation("Мы не знаем где ты (")
            }
        }
        fetchCategoryData()
    }
    
    func collectionCellDidTapped(at indexPath: IndexPath)  {
        categories.forEach { $0.isSelected = false }
        categories[indexPath.row].isSelected = true
        view.categoriesDidRecieve(categories)
    }
}

// MainScreenPresenter private functions

extension MainScreenPresenter {
    private func fetchCategoryData() {
        categories = DataManager().getCategories()
        view.categoriesDidRecieve(categories)
    }
}
