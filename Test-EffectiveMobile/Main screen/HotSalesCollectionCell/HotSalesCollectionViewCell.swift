//
//  HotSalesCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 27.08.2022.
//

import UIKit

class HotSalesCollectionViewCell: UICollectionViewCell {
    
    
    var viewModel: Product! {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateCell() {
        
    }

}
