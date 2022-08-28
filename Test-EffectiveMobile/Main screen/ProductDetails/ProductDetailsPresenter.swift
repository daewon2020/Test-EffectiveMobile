//
//  ProductDetailsPresenter.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import Foundation

protocol ProductDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    unowned let view: ProductDetailsVCProtocol
    
    init(view: ProductDetailsVCProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        NetworkManager.shared.fetchData(
            with: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5",
            for: ProductDetailsModel.self
        ){ (data: ProductDetailsModel) in
            print(data)
        }
    }
}
