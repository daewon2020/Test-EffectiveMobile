//
//  ProductDetailsPresenter.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import Foundation

protocol ProductDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func collectionViewCountResponse(_ collectionViewTag: Int) -> Int
    func tabsResponseForCell(at indexPath: IndexPath) -> String
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    unowned let view: ProductDetailsVCProtocol
    
    private var productDetailsViewModel: ProductDetailsModel?
    private var productParamTabs: [String]?
    private var productImages: [String]?
    
    init(view: ProductDetailsVCProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func collectionViewCountResponse(_ collectionViewTag: Int) -> Int {
        guard let viewModel = productDetailsViewModel else { return 0}
        
        switch collectionViewTag {
        case 0: return viewModel.color.count
        case 1: return viewModel.capacity.count
        case 2: return 4
        case 3:
            guard let tabsCount = productParamTabs else { return 0}
            return tabsCount.count
        case 4: return viewModel.images.count
        default: return 0
        }
    }
    
    func tabsResponseForCell(at indexPath: IndexPath) -> String {
        guard let patamTab = productParamTabs?[indexPath.row] else { return "" }
        return patamTab
    }
}

//MARK: - Private functions

extension ProductDetailsPresenter {
    private func fetchData() {
        productParamTabs = DataManager().getparamTabs()
        NetworkManager.shared.fetchData(
            with: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5",
            for: ProductDetailsModel.self
        ){ (data: ProductDetailsModel) in
            self.productDetailsViewModel = data
            self.dataDidRecieve()
        }
    }
    
    private func dataDidRecieve() {
        guard let viewModel = productDetailsViewModel else { return }
        view.setProductHeaderParams(title: viewModel.title)
        view.productDetailsDidRecieve(viewModel)
    }
}
