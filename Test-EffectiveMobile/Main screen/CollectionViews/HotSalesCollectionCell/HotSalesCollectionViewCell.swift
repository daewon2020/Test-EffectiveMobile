//
//  HotSalesCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 27.08.2022.
//

import UIKit

final class HotSalesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var isNewButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitlelabel: UILabel!
    @IBOutlet weak var byeNowButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    var viewModel: Product! {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        if let isNew = viewModel.isNew {
            isNewButton.isHidden = isNew
        } else {
            isNewButton.isHidden = false
        }
        image.layer.cornerRadius = 10
        titleLabel.text = viewModel.title
        subTitlelabel.text  = viewModel.subtitle
        
        ImageLoader.shared.getImageFromCache(for: viewModel.picture) { image in
            self.image.image = image
        }
    }
}
