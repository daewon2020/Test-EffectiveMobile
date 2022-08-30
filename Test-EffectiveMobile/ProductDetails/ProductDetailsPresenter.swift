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
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    unowned let view: ProductDetailsVCProtocol
    
    private var productDetailsViewModel: ProductDetailsModel?
    
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
        default: return 0
        }
    }
}

//MARK: - Private functions

extension ProductDetailsPresenter {
    private func fetchData() {
        NetworkManager.shared.fetchData(
            with: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5",
            for: ProductDetailsModel.self
        ){ (data: ProductDetailsModel) in
            self.productDetailsViewModel = data
            self.view.productDetailsDidRecieve(data)
        }
    }
}
