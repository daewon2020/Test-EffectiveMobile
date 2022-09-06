//
//  CollectionViewDelegate.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 06.09.2022.
//

import Foundation
import UIKit

final class MainScreenCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    private unowned var presenter: MainScreenPresenterProtocol
    private unowned var delegate: MainScreenVCDelegateProtocol
    
    init(with presenter: MainScreenPresenterProtocol, and delegate: MainScreenVCDelegateProtocol) {
        self.presenter = presenter
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        
        case 0:
            presenter.collectionCellDidTapped(at: indexPath)
        case 2:
            delegate.selectedBestsellerProduct()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 2:
            return CGSize(width: collectionView.frame.width / 2 - 4, height: 227)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 182)
        case 0:
            return CGSize(width: 80, height: 100)
        default:
            return CGSize.zero
        }
    }
}
