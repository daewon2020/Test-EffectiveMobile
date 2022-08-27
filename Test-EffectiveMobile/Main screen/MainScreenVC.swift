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
    @IBOutlet weak var hotSalesCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    private var presenter: MainScreenPresenterProtocol!
    private var categories = [CategoryCollectionViewModelProtocol]()
    private var hotSales = [Product]()
    private var bestseller = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        searchBar.searchTextField.backgroundColor = .white
        hotSalesCollectionView.register(
            UINib(
                nibName: "HotSalesCollectionViewCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "hotSalesCellID")
        
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
        switch collectionView{
        case hotSalesCollectionView:
            return hotSales.count
        case categoryCollectionView:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoryCellID",
            for: indexPath
        )
        
        
        if collectionView == categoryCollectionView  {
            if let categoryCell = cell as? CategoryCollectionViewCell {
                categoryCell.viewModel = categories[indexPath.row]
            }
        }
        
        if collectionView == hotSalesCollectionView  {
            if let hotSaleCell = cell as? CategoryCollectionViewCell {
               // hotSaleCell.viewModel = hotSales
            }
        }
        
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
