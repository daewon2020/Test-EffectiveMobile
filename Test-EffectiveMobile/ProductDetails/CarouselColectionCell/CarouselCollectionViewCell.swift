//
//  CarouselCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    var viewModel: CarouselCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var caourelImageView: UIImageView = {
        let caourelImageView = UIImageView()
        caourelImageView.translatesAutoresizingMaskIntoConstraints = false
        caourelImageView.contentMode = .scaleToFill
        caourelImageView.tintColor = .black
        
        return caourelImageView
    }()
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func updateCell() {
        
        ImageLoader.shared.getImageFromCache(for: viewModel.image) { image in
            self.caourelImageView.image = image
        }
        
        if !isSelected {
            
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        clipsToBounds = false
        backgroundColor = .white
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor(hex: "#374E88")?.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        addSubview(caourelImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                caourelImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                caourelImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                caourelImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                caourelImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ]
        )
    }
}

