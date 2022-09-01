//
//  CapacityCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 30.08.2022.
//

import UIKit

class CapacityCollectionViewCell: UICollectionViewCell {
    
    var viewModel: CapacityCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        isSelected = false
    }
    
    private func updateCell() {
        let capacityLabel = UILabel()
        
        capacityLabel.translatesAutoresizingMaskIntoConstraints = false
        capacityLabel.textColor = isSelected ? .white : UIColor(hex: "#8D8D8D")
        capacityLabel.text = viewModel.title
        capacityLabel.textAlignment = .center
        capacityLabel.font = UIFont.init(name: "Mark Pro Bold", size: 13)
        
        if isSelected {
            backgroundColor = UIColor(hex: "#FF6E4E")
            capacityLabel.textColor = .white
            
        }else {
            backgroundColor = .white
            capacityLabel.textColor = UIColor(hex: "#8D8D8D")
        }
        
        layer.masksToBounds = false
        layer.cornerRadius = 10
        addSubview(capacityLabel)
        
        setConstraints(for: capacityLabel)
    }
    
    private func setConstraints(for capacityLabel: UILabel) {
        NSLayoutConstraint.activate(
            [
                capacityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                capacityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                capacityLabel.heightAnchor.constraint(equalToConstant: frame.height),
                capacityLabel.widthAnchor.constraint(equalToConstant: frame.width)
            ]
        )
    }
}
