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

protocol MainScreenVCDelegateProtocol: AnyObject {
    func selectedBrandForFilter(_ brand: String)
    func selectedPriceForFilter(_ price: String)
    func selectedSizeForFilter(_ size: String)
    func selectedBestsellerProduct()
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
    @IBOutlet weak var filterBrandTextField: UITextField!
    @IBOutlet weak var filterPriceTextField: UITextField!
    @IBOutlet weak var filterSizeTextField: UITextField!
    
    private var presenter: MainScreenPresenterProtocol!
    private var pickerViewDataSource: FilterPickerViewDataSource!
    private var pickerViewDelegate: FilterPickerViewDelegate!
    private var collectionViewDataSource: CollectionViewDataSource!
    private var collectionViewDelegate: CollectionViewDelegate!
    
    private var keyboardIsShown = false
    private var brandPickerView = UIPickerView()
    private var pricePickerView = UIPickerView()
    private var sizePickerView = UIPickerView()
    
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
            action: #selector(setTabBarButtonTapped)
        )
        
        toolBar.setItems([cancelButton,space,setButton], animated: true)
        
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainScreenPresenter(view: self)
        
        pickerViewDataSource = FilterPickerViewDataSource()
        pickerViewDelegate = FilterPickerViewDelegate(withDelegate: self)
        
        collectionViewDataSource = CollectionViewDataSource(with: presenter, and: self)
        collectionViewDelegate = CollectionViewDelegate(with: presenter, and: self)
        
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        
        bottomBarView.layer.cornerRadius = 30

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        setupCollectionViews()
        presenter.viewDidLoad()
        setupPickerViews()
        setupTextFields()
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

//MARK: - UITextFieldDelegate

extension MainScreenVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
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
    
    func setLocation(_ location: String) {
        locationButton.setTitle(location, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProductDetailsVC {
            guard let productDetails = segue.destination as? ProductDetailsVC else { return }
            productDetails.presenter = ProductDetailsPresenter(view: productDetails)
        }
    }
}

//MARK:- MainScreenVCDelegateProtocol

extension MainScreenVC: MainScreenVCDelegateProtocol {
    func selectedPriceForFilter(_ price: String) {
        filterPriceTextField.text = price
    }
    
    func selectedSizeForFilter(_ size: String) {
        filterSizeTextField.text = size
    }
    
    func selectedBrandForFilter(_ brand: String) {
        filterBrandTextField.text = brand
    }
    
    func selectedBestsellerProduct() {
        performSegue(withIdentifier: "productDetailID", sender: nil)
    }
}

//MARK: - Private functions

extension MainScreenVC {
    private func setupCollectionViews() {
        categoryCollectionView.dataSource = collectionViewDataSource
        categoryCollectionView.delegate = collectionViewDelegate
        categoryCollectionView.allowsSelection = true
        categoryCollectionView.allowsMultipleSelection = false
        
        hotSalesCollectionView.dataSource = collectionViewDataSource
        hotSalesCollectionView.delegate = collectionViewDelegate
        hotSalesCollectionView.allowsMultipleSelection = false
        hotSalesCollectionView.allowsSelection = false
        
        bestsellersCollectionView.dataSource = collectionViewDataSource
        bestsellersCollectionView.delegate = collectionViewDelegate
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
        filterBrandTextField.resignFirstResponder()
        filterPriceTextField.resignFirstResponder()
        filterSizeTextField.resignFirstResponder()
    }
    
    @objc private func setTabBarButtonTapped() {
        keyboardIsShown = false
        filterBrandTextField.resignFirstResponder()
        filterPriceTextField.resignFirstResponder()
        filterSizeTextField.resignFirstResponder()
    }
    
    @objc private func keyboardDidShown() {
        if !keyboardIsShown {
            filerViewBottomConstraint.constant += 200
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
                self.view.layoutIfNeeded()
            }
            keyboardIsShown = true
        }
    }
    
    @objc private func keyboardDidHide() {
        keyboardIsShown = false
        filerViewBottomConstraint.constant -= 200
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupPickerViews() {
        brandPickerView.tag = 0
        brandPickerView.dataSource = pickerViewDataSource
        brandPickerView.delegate = pickerViewDelegate
        
        pricePickerView.tag = 1
        pricePickerView.dataSource = pickerViewDataSource
        pricePickerView.delegate = pickerViewDelegate
        
        sizePickerView.tag = 2
        sizePickerView.dataSource = pickerViewDataSource
        sizePickerView.delegate = pickerViewDelegate
    }
    
    private func setupTextFields() {
        filterBrandTextField.inputAccessoryView = toolBar
        filterBrandTextField.inputView = brandPickerView
        filterBrandTextField.delegate = self
        
        filterPriceTextField.inputAccessoryView = toolBar
        filterPriceTextField.inputView = pricePickerView
        filterPriceTextField.delegate = self
        
        filterSizeTextField.inputAccessoryView = toolBar
        filterSizeTextField.inputView = sizePickerView
        
        filterView.layer.cornerRadius = 20
        filterView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        filterBrandTextField.rightView = UIImageView(image: UIImage(systemName: "chevron.down"))
        filterPriceTextField.rightView = UIImageView(image: UIImage(systemName: "chevron.down"))
        filterSizeTextField.rightView = UIImageView(image: UIImage(systemName: "chevron.down"))
        
        filterBrandTextField.rightView?.tintColor = UIColor(hex: "#B3B3B3")
        filterPriceTextField.rightView?.tintColor = UIColor(hex: "#B3B3B3")
        filterSizeTextField.rightView?.tintColor = UIColor(hex: "#B3B3B3")
        
        filterBrandTextField.rightViewMode = .always
        filterSizeTextField.rightViewMode = .always
        filterPriceTextField.rightViewMode = .always
    }
}


