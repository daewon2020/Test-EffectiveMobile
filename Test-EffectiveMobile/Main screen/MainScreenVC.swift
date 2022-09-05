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
    func favoriteButtonTapped(at cell: UICollectionViewCell)
}

final class MainScreenVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var hotSalesCollectionView: UICollectionView!
    @IBOutlet weak var bestsellersCollectionView: UICollectionView!
    @IBOutlet weak var bottomBarView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var filerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filerBrandTextField: UITextField!
    @IBOutlet weak var filterPriceTextField: UITextField!
    @IBOutlet weak var filterSizeTextField: UITextField!
    
    private var presenter: MainScreenPresenterProtocol!
    private var keyboardIsShown = false
    lazy var pickerView = UIPickerView()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(cancelTabBarButtonTapped)
        )
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let setButton = UIBarButtonItem(
            title: "Set",
            style: .done,
            target: self,
            action: nil
        )
        
        toolBar.setItems([cancelButton,space,setButton], animated: true)
        
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        bottomBarView.layer.cornerRadius = 30
        
        filterView.layer.cornerRadius = 20
        filterView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        filerBrandTextField.inputAccessoryView = toolBar
        filerBrandTextField.inputView = pickerView
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        filerBrandTextField.rightView = imageView
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        setupCollectionViews()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func filterCloseButtonTapped() {
        if keyboardIsShown {
            cancelTabBarButtonTapped()
        }
        filerViewBottomConstraint.constant -= 400
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
                self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func filerButtonTapped() {
        if filerViewBottomConstraint.constant == -400 {
            filerViewBottomConstraint.constant += 400
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

//MARK: - UISearchBarDelegate

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
    
    func favoriteButtonTapped(at cell: UICollectionViewCell) {
        if let indexPath = bestsellersCollectionView.indexPath(for: cell) {
            presenter.favoriteButtonTapped(at: indexPath)
        }
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
            cell.parentView = self
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
    
    @objc private func cancelTabBarButtonTapped() {
        keyboardIsShown = false
        filerBrandTextField.resignFirstResponder()
        filerViewBottomConstraint.constant -= 200
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowAnimatedContent]) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardDidShown() {
        keyboardIsShown = true
        filerViewBottomConstraint.constant += 200
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.view.layoutIfNeeded()
        }
    }
}
