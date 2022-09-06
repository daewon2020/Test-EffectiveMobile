//
//  CarouselCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    var viewModel: CarouselCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var carouselImageView: UIImageView = {
        let carouselImageView = UIImageView()
        carouselImageView.translatesAutoresizingMaskIntoConstraints = false
        carouselImageView.contentMode = .scaleAspectFit
        
        return carouselImageView
    }()
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        removeConstraints(constraints)
        carouselImageView.removeConstraints(carouselImageView.constraints)
    }
    
    private func updateCell() {
        var image: UIImage? = nil
        
        if !isSelected {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        backgroundColor = .white
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor(hex: "#374E88")?.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        
        ImageLoader.shared.getImageFromCache(for: viewModel.image) { loadedImage in
            image = loadedImage
            let width = self.frame.width > self.frame.height
            ? self.frame.width
            : self.frame.width - 40
            
            self.addSubview(self.carouselImageView)
            
            self.setConstraintsForImageView(with: width)
            self.carouselImageView.image = image
        }
    }
    
    private func setConstraintsForImageView(with width: CGFloat) {
        NSLayoutConstraint.activate([
            carouselImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            carouselImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            carouselImageView.widthAnchor.constraint(equalToConstant: width),
            carouselImageView.heightAnchor.constraint(equalToConstant: frame.height)
        ])
    }
}

