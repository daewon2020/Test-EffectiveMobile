//
//  ParamTabsCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 31.08.2022.
//

import UIKit

final class ParamTabsCollectionViewCell: UICollectionViewCell {
    var viewModel: ParamTabsCollectionViewCellModelProtocol! {
        didSet {
            updateCell()
        }
    }
    
    lazy var paramLabel: UILabel = {
        let paramLabel = UILabel()
        paramLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        paramLabel.textAlignment = .center
        
        
        return paramLabel
    }()
    
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
        isSelected = false
    }
    
    func updateCell() {
        if isSelected {
            paramLabel.textColor = .black.withAlphaComponent(1)
            paramLabel.font = UIFont.init(name: "Mark Pro Bold", size: 20)
            let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2))
            bottomLine.backgroundColor = UIColor(hex: "#FF6E4E")
            addSubview(bottomLine)
        } else {
            paramLabel.textColor = .black.withAlphaComponent(0.5)
            paramLabel.font = UIFont.init(name: "Mark Pro", size: 20)
        }
        
        paramLabel.text = viewModel.title
        
        addSubview(paramLabel)
    }
}
