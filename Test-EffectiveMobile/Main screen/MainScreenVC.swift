//
//  ViewController.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 25.08.2022.
//

import UIKit

protocol MainScreenVCProtocol: AnyObject {
    func reloadCategories()
    func productsDidRecieve()

    func setLocation(_ location: String)
}

final class MainScreenVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var hotSalesCollectionView: UICollectionView!
    @IBOutlet weak var bestsellersCollectionView: UICollectionView!
    @IBOutlet weak var bottomBarView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    private var presenter: MainScreenPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        bottomBarView.layer.cornerRadius = 30
        
        setupCollectionViews()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - 

extension MainScreenVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            searchBar.resignFirstResponder()
            return false
        }
        return true
    }
}

//MARK: - MainScreenVCProtocol

extension MainScreenVC: MainScreenVCProtocol {
    func reloadCategories() {
        categoryCollectionView.reloadData()
    }
    
    func productsDidRecieve() {
        hotSalesCollectionView.reloadData()
        bestsellersCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProductDetailsVC {
            guard let productDetails = segue.destination as? ProductDetailsVC else { return }
            productDetails.presenter = ProductDetailsPresenter(view: productDetails)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MainScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.productCount(for: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == categoryCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "categoryCellID",
                for: indexPath
            ) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            
            cell.viewModel = presenter.categoryRequest(for: indexPath)
            return cell
        }
        
        if collectionView == hotSalesCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "hotSalesCellID",
                for: indexPath
            ) as? HotSalesCollectionViewCell else { return UICollectionViewCell() }
                
            cell.viewModel = presenter.productRequest(with: collectionView.tag, for: indexPath)
            return cell
        }
        
        if collectionView == bestsellersCollectionView  {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "bestsellersCellID",
                for: indexPath
            ) as? BestsellersCollectionViewCell else { return UICollectionViewCell() }
                
            cell.viewModel = presenter.productRequest(with: collectionView.tag, for: indexPath)
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
        
        if collectionView == bestsellersCollectionView  {
            performSegue(withIdentifier: "productDetailID", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case bestsellersCollectionView:
            return CGSize(width: bestsellersCollectionView.frame.width / 2 - 4, height: 227)
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
    private func setupCollectionViews() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.allowsSelection = true
        categoryCollectionView.allowsMultipleSelection = false
        
        hotSalesCollectionView.dataSource = self
        hotSalesCollectionView.delegate = self
        hotSalesCollectionView.allowsMultipleSelection = false
        hotSalesCollectionView.allowsSelection = false
        
        bestsellersCollectionView.dataSource = self
        bestsellersCollectionView.delegate = self
        bestsellersCollectionView.allowsMultipleSelection = false
        bestsellersCollectionView.allowsSelection = true
        
        categoryCollectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: "categoryCellID"
        )
    
        
        hotSalesCollectionView.register(
            UINib(nibName: "HotSalesCollectionViewCell",bundle: nil),
            forCellWithReuseIdentifier: "hotSalesCellID"
        )
        
        bestsellersCollectionView.register(
            UINib(nibName: "BestsellersCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "bestsellersCellID"
        )
    }
}
