//
//  RatingCollectionViewCell.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 01.09.2022.
//

import UIKit

final class RatingCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let carouselImageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.height
            )
        )
        
        carouselImageView.image = UIImage(named: "star")
        addSubview(carouselImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


