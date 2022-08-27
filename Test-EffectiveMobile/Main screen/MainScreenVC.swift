//
//  ViewController.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import UIKit

protocol MainScreenVCProtocol: AnyObject {
    func categoriesDidRecieve(_ categories: [CategoryCollectionViewModelProtocol])
    func setLocation(_ location: String)
}

final class MainScreenVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    private var presenter: MainScreenPresenterProtocol!
    private var categories = [CategoryCollectionViewModelProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        searchBar.searchTextField.backgroundColor = .white
        
        
        presenter.viewDidLoad()
        
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
    
    func setLocation(_ location: String) {
        locationButton.setTitle(location, for: .normal)
    }
}

//MARK: - Private functions

extension MainScreenVC {
    
}
