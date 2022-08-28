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
    private var hotSalesProducts = [Product]()
    private var bestsellerProducts = [Product]()
    
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
        fetchHotSalesData()
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
    
    private func fetchHotSalesData() {
        NetworkManager.shared.fetchProducts(with: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") { products in
            self.bestsellerProducts = products.bestSeller
            self.hotSalesProducts = products.homeStore
            self.view.hotSalesProductsDidRecieve(self.hotSalesProducts)
            self.view.bestsellersProductsDidRecieve(self.bestsellerProducts)
        }
        
    }
}
