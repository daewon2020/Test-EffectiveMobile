//
//  MainScreenPresenter.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import Foundation
import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func collectionCellDidTapped(at indexPath: IndexPath)
    func categoryRequest(for indexPath: IndexPath) -> CategoryCollectionViewModelProtocol
    func productCount(for collectionViewTag: Int) -> Int
    func productRequest(with collectionViewTag: Int, for indexPath: IndexPath) -> Product?
    func favoriteButtonTapped(at indexPath: IndexPath)
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
        view.reloadCategories()
    }
    
    func categoryRequest(for indexPath: IndexPath) -> CategoryCollectionViewModelProtocol {
        categories[indexPath.row]
    }
    
    func productRequest(with collectionViewTag: Int, for indexPath: IndexPath) -> Product? {
        switch collectionViewTag {
        case 1: return hotSalesProducts[indexPath.row]
        case 2: return bestsellerProducts[indexPath.row]
        default: return nil
        }
    }
    
    func productCount(for collectionViewTag: Int) -> Int {
        switch collectionViewTag {
        case 0: return categories.count
        case 1: return hotSalesProducts.count
        case 2: return bestsellerProducts.count
        default: return 0
        }
    }
    
    func favoriteButtonTapped(at indexPath: IndexPath) {
        bestsellerProducts[indexPath.row].isFavorites!.toggle()
        view.productsDidRecieve()
    }
}

//MARK: - MainScreenPresenter private functions

extension MainScreenPresenter {
    private func fetchCategoryData() {
        categories = DataManager.shared.getCategories()
        view.reloadCategories()
    }
    
    private func fetchHotSalesData() {
        NetworkManager.shared.fetchData(
            with: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175",
            for: ProductModel.self
        ) { (products: ProductModel)  in
            self.bestsellerProducts = products.bestSeller
            self.hotSalesProducts = products.homeStore
            self.view.productsDidRecieve()
        }
    }
}
