//
//  CollectionViewDataSource.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 06.09.2022.
//

import Foundation
import UIKit

final class MainScreenCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private unowned var presenter: MainScreenPresenterProtocol
    private unowned var parentView: MainScreenVC
    
    init(with presenter: MainScreenPresenterProtocol, and parentView: MainScreenVC) {
        self.presenter = presenter
        self.parentView = parentView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.productCount(for: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "categoryCellID",
                for: indexPath
            ) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            
            cell.viewModel = presenter.categoryRequest(for: indexPath)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "hotSalesCellID",
                for: indexPath
            ) as? HotSalesCollectionViewCell else { return UICollectionViewCell() }
            
            cell.viewModel = presenter.productRequest(with: collectionView.tag, for: indexPath)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "bestsellersCellID",
                for: indexPath
            ) as? BestsellersCollectionViewCell else { return UICollectionViewCell() }
            cell.parentView = parentView
            cell.viewModel = presenter.productRequest(with: collectionView.tag, for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
