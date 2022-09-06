//
//  ColorCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 29.08.2022.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    var viewModel: ColorCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var colorImageView: UIImageView = {
        let colorImageView = UIImageView()
        colorImageView.image = UIImage(systemName: "checkmark")
        colorImageView.translatesAutoresizingMaskIntoConstraints = false
        colorImageView.contentMode = .scaleAspectFit
        
        return colorImageView
    }()
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        isSelected = false
    }
    
    private func updateCell() {
        backgroundColor = UIColor(hex: viewModel.color)
        colorImageView.isHidden = isSelected ? false : true
        colorImageView.tintColor = backgroundColor == .white ? .black : .white
        
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
        addSubview(colorImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                colorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                colorImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                colorImageView.heightAnchor.constraint(equalToConstant: frame.height / 2),
                colorImageView.widthAnchor.constraint(equalToConstant: frame.width / 2)
            ]
        )
    }
}
