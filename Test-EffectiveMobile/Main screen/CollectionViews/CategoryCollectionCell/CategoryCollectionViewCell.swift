//
//  CategoryCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    var viewModel: CategoryCollectionViewModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    private lazy var circleView: UIView = {
        let circleView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 71, height: 71
            )
        )

        circleView.layer.cornerRadius = circleView.frame.height / 2
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        return circleView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var categoryName: UILabel = {
        let categoryName = UILabel()

        categoryName.tintColor = .black
        categoryName.textAlignment = .center
        categoryName.font = UIFont.systemFont(ofSize: 12)
        
        return categoryName
    }()
    
    private func updateCell() {
        let image = UIImage(named: viewModel.image)
        let imageView = UIImageView(image: image)

        categoryName.text = viewModel.name
        
        if viewModel.isSelected {
            categoryName.textColor = #colorLiteral(red: 1, green: 0.431372549, blue: 0.3058823529, alpha: 1)
            imageView.tintColor = UIColor.white
            circleView.backgroundColor = #colorLiteral(red: 1, green: 0.431372549, blue: 0.3058823529, alpha: 1)
            
        } else {
            categoryName.textColor = .black
            imageView.tintColor = UIColor.gray
            circleView.backgroundColor = .white
        }
        
        circleView.addSubview(imageView)
        
        imageView.center.x = circleView.frame.height / 2
        imageView.center.y = circleView.frame.width / 2
        
        stackView.addArrangedSubview(circleView)
        stackView.addArrangedSubview(categoryName)
        addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalToConstant: 80),
            circleView.widthAnchor.constraint(equalToConstant: 71),
            circleView.heightAnchor.constraint(equalToConstant: 71),
        ])
    }
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        stackView.subviews.forEach { $0.removeFromSuperview() }
        circleView.subviews.forEach { $0.removeFromSuperview() }
    }
}
