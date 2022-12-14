//
//  BestsellersCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import UIKit

final class BestsellersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    unowned var parentView: MainScreenVC!

    var viewModel: Product! {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        layer.cornerRadius = 10
        
        let priceAtrrString = NSMutableAttributedString(
            string: String(viewModel.discountPrice ?? 0) + "  ",
            attributes: [.font: UIFont.init(name: "Mark Pro Bold", size: 16)!]
        )
        
        let oldPrice = NSAttributedString(
            string: String(viewModel.priceWithoutDiscount ?? 0),
            attributes: [
                .strikethroughStyle : NSUnderlineStyle.single.rawValue,
                .font: UIFont.init(name: "Mark Pro Medium", size: 10)!,
                .foregroundColor: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            ]
        )
        
        priceAtrrString.append(oldPrice)
        priceLabel.attributedText = priceAtrrString
        
        isFavoriteButton.layer.shadowColor = UIColor.black.cgColor
        isFavoriteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        isFavoriteButton.layer.masksToBounds = false
        isFavoriteButton.layer.shadowRadius = 8
        isFavoriteButton.layer.shadowOpacity = 0.2
        
        if let isFavorite = viewModel.isFavorites {
            isFavoriteButton.isHidden = false
            isFavorite
            ? isFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            : isFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            isFavoriteButton.isHidden = true
            
        }
        image.layer.cornerRadius = 10
        
        ImageLoader.shared.getImageFromCache(for: viewModel.picture) { image in
            self.image.image = image
        }
        
        titleLabel.text = viewModel.title
        titleLabel.font = UIFont.systemFont(ofSize: 10)
    }
    
    @IBAction func favoriteButtonTapped() {
        parentView.favoriteButtonTapped(at: self)
    }
}
