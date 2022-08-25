//
//  ViewController.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import UIKit

protocol MainScreenVCProtocol: AnyObject {
    func categoriesDidRecieve(_ categories: [CategoryCollectionViewModelProtocol])
}

final class MainScreenVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var presenter: MainScreenPresenterProtocol!
    private var categories = [CategoryCollectionViewModelProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        presenter.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        categoryCollectionView.visibleCells.forEach { cell in
            guard let categoryCell = cell as? CategoryCollectionViewCell else { return }
            categoryCell.prepareForReuse()
        }
        
        categoryCollectionView.reloadData()
    }
}

//MARK: - MainScreenVCProtocol

extension MainScreenVC: MainScreenVCProtocol {
    func categoriesDidRecieve(_ categories: [CategoryCollectionViewModelProtocol]) {
        self.categories = categories
        categoryCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource

extension MainScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoryCellID",
            for: indexPath
        ) as? CategoryCollectionViewCell else { return UICollectionViewCell()}

        cell.viewModel = categories[indexPath.row]
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.collectionCellDidTapped(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 100)
    }
}
