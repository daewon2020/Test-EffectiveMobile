//
//  ViewController.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import UIKit

protocol MainScreenVCProtocol: AnyObject {
    func categoriesDidRecieve(_ categories: [CategoryCollectionViewModelProtocol])
    func hotSalesProductsDidRecieve(_ hotSalesProducts: [Product])
    func setLocation(_ location: String)
}

final class MainScreenVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var hotSalesCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    private var presenter: MainScreenPresenterProtocol!
    private var categories = [CategoryCollectionViewModelProtocol]()
    private var hotSalesProducts = [Product]()
    private var bestsellerProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.allowsSelection = true
        categoryCollectionView.allowsMultipleSelection = false
        
        hotSalesCollectionView.dataSource = self
        hotSalesCollectionView.delegate = self
        hotSalesCollectionView.allowsMultipleSelection = false
        hotSalesCollectionView.allowsSelection = false
        
        searchBar.searchTextField.backgroundColor = .white
        hotSalesCollectionView.register(
            UINib(
                nibName: "HotSalesCollectionViewCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "hotSalesCellID"
        )
        
        presenter.viewDidLoad()
        
    }
}

//MARK: - MainScreenVCProtocol

extension MainScreenVC: MainScreenVCProtocol {
    func categoriesDidRecieve(_ categories: [CategoryCollectionViewModelProtocol]) {
        self.categories = categories
        categoryCollectionView.reloadData()
    }
    
    func hotSalesProductsDidRecieve(_ hotSalesProducts: [Product]) {
        self.hotSalesProducts = hotSalesProducts
        hotSalesCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource

extension MainScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case hotSalesCollectionView:
            return hotSalesProducts.count
        case categoryCollectionView:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "categoryCellID",
                for: indexPath
            ) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            
            cell.viewModel = categories[indexPath.row]
            return cell
        }
        
        if collectionView == hotSalesCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "hotSalesCellID",
                for: indexPath
            ) as? HotSalesCollectionViewCell else { return UICollectionViewCell() }
                
            cell.viewModel = hotSalesProducts[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView  {
            presenter.collectionCellDidTapped(at: indexPath)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case hotSalesCollectionView:
            return CGSize(width: hotSalesCollectionView.frame.width, height: 182)
        case categoryCollectionView:
            return CGSize(width: 80, height: 100)
        default:
            return CGSize.zero
        }   
    }
    
    func setLocation(_ location: String) {
        locationButton.setTitle(location, for: .normal)
    }
}

//MARK: - Private functions

extension MainScreenVC {
    
}
