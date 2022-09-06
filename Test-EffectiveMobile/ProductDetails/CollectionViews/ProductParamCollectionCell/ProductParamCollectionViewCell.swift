//
//  ProductParamCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 30.08.2022.
//

import UIKit

final class ProductParamCollectionViewCell: UICollectionViewCell {
    var viewModel: ProductParamCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var paramImageView: UIImageView = {
        let paramImageView = UIImageView()
        paramImageView.translatesAutoresizingMaskIntoConstraints = false
        paramImageView.contentMode = .scaleAspectFit
        paramImageView.tintColor = .black
        
        return paramImageView
    }()
    
    lazy var paramLabel: UILabel = {
        let paramLabel = UILabel()
        
        paramLabel.translatesAutoresizingMaskIntoConstraints = false
        paramLabel.textColor = UIColor(hex: "#8D8D8D")
        paramLabel.textAlignment = .center
        paramLabel.font = UIFont.init(name: "Mark Pro", size: 11)
        
        return paramLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        isSelected = false
    }
    
    private func updateCell() {
        paramImageView.image = UIImage.init(named: viewModel.image)
        paramLabel.text = viewModel.title
        stackView.addArrangedSubview(paramImageView)
        stackView.addArrangedSubview(paramLabel)
        addSubview(stackView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                paramImageView.heightAnchor.constraint(equalToConstant: 28),
                paramImageView.widthAnchor.constraint(equalToConstant: 28),
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            ]
        )
    }
}
