//
//  CartTableViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 04.09.2022.
//

import UIKit

final class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    
    unowned var parentView: CartVCProtocol!
    
    var viewModel: Basket! {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        productNameLabel.text = viewModel.title
        productPriceLabel.text = "\(viewModel.price)"
        productCountLabel.text = "\(viewModel.count ?? 1)"
        
        ImageLoader.shared.getImageFromCache(for: viewModel.images) { image in
            self.productImageView.image = image
        }
    }
   
    @IBAction func munisButtonTapped() {
        parentView.minusButtonTapped(at: self)
    }
    
    @IBAction func plusButtonTapped() {
        parentView.plusButtonTapped(at: self)
    }
    
    @IBAction func deleteButtonTapped() {
        parentView.deleteButtonTapped(at: self)
    }
}
