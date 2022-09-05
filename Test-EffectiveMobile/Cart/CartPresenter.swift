//
//  CartPresenter.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 02.09.2022.
//

import Foundation

protocol CartPresenterProrocol {
    func viewDidLoad()
    func plusButtonTapped(at indexPath: IndexPath)
    func minusButtonTapped(at indexPath: IndexPath)
    func deleteButtonTapped(at indexPath: IndexPath)
}

class CartPresenter: CartPresenterProrocol {
    
    unowned let view: CartVCProtocol!
    
    private var product: CartModel!
    
    init(view: CartVC) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func plusButtonTapped(at indexPath: IndexPath) {
        var currentCount = product.basket[indexPath.row].count ?? 1
        if currentCount < 100 {
            currentCount += 1
            product.basket[indexPath.row].count = currentCount
            view.countDidChange(at: indexPath, with: currentCount)
            view.setTotalPriceText(price: calculateTotalPrice())
        }
    }
    
    func minusButtonTapped(at indexPath: IndexPath) {
        var currentCount = product.basket[indexPath.row].count ?? 1
        if currentCount > 1 {
            currentCount -= 1
            product.basket[indexPath.row].count = currentCount
            view.countDidChange(at: indexPath, with: currentCount)
            view.setTotalPriceText(price: calculateTotalPrice())
        }
    }
    func deleteButtonTapped(at indexPath: IndexPath) {
        product.basket.remove(at: indexPath.row)
        view.dataDidRecieve(viewModel: product)
        view.setTotalPriceText(price: calculateTotalPrice())
    }
}

// MARK: - private functions

extension CartPresenter {
    private func fetchData() {
        NetworkManager.shared.fetchData(
            with: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149",
            for: CartModel.self
        ){ (data: CartModel) in
            self.product = data
            let totalPrice = self.calculateTotalPrice()
            self.view.dataDidRecieve(viewModel: data)
            self.view.setTotalPriceText(price: totalPrice)
            self.view.setDeliveryText(delivery: data.delivery)
        }
    }
    
    private func calculateTotalPrice() -> Double {
        let totalPrice = product.basket.reduce(0) { partialResult, basket in
            partialResult + basket.price * Double(basket.count ?? 1)
        }
        return totalPrice
    }
    
}
