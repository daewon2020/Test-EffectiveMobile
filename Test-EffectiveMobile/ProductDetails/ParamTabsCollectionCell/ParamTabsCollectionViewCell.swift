//
//  ParamTabsCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import UIKit

class ParamTabsCollectionViewCell: UICollectionViewCell {
    var viewModel: ParamTabsCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var paramLabel: UILabel = {
        let paramLabel = UILabel()
        
        paramLabel.translatesAutoresizingMaskIntoConstraints = false
        paramLabel.textAlignment = .center
        
        return paramLabel
    }()
    
    func updateCell() {
        if isSelected {
            paramLabel.textColor = .black.withAlphaComponent(1)
            paramLabel.font = UIFont.init(name: "Mark Pro Bold", size: 20)
        } else {
            paramLabel.textColor = .black.withAlphaComponent(0.5)
            paramLabel.font = UIFont.init(name: "Mark Pro", size: 20)
        }
        paramLabel.text = viewModel.title
        addSubview(paramLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                paramLabel.heightAnchor.constraint(equalToConstant: frame.height),
                paramLabel.widthAnchor.constraint(equalToConstant: frame.width)
            ]
        )
    }
}
