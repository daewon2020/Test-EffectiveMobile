//
//  ProductDetailsVC.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import UIKit
protocol ProductDetailsVCProtocol: AnyObject {
    func productDetailsDidRecieve(_ viewModel: ProductDetailsModel)
}

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var capacityCollectionView: UICollectionView!
    @IBOutlet weak var productParamView: UIView!
    
    private var productDetailsViewModel: ProductDetailsModel!
    private var colorSelectedCell: Int? = nil
    private var capacitySelectedCell: Int? = nil
    
    var presenter: ProductDetailsPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        setupUI()
        setupCollectionViews()
    }
}


//MARK: - ProductDetailsVCProtocol

extension ProductDetailsVC: ProductDetailsVCProtocol {
    func productDetailsDidRecieve(_ viewModel: ProductDetailsModel) {
        productDetailsViewModel = viewModel
        colorCollectionView.reloadData()
        capacityCollectionView.reloadData()
    }
}

//MARK: - Private functions

extension ProductDetailsVC {
    private func setupUI() {
        productParamView.layer.cornerRadius = 30
        productParamView.layer.shadowColor = UIColor.black.cgColor
        productParamView.layer.shadowRadius = 20
        productParamView.layer.shadowOpacity = 0.1
        productParamView.layer.shadowOffset = CGSize(width: 0, height: -5)
        productParamView.clipsToBounds = false
        addToCartButton.layer.cornerRadius = 10
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    private func setupCollectionViews() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.allowsMultipleSelection = false
        colorCollectionView.allowsSelection = true
        
        colorCollectionView.register(
            ColorCollectionViewCell.self,
            forCellWithReuseIdentifier: "colorCellID"
        )
        
        capacityCollectionView.delegate = self
        capacityCollectionView.dataSource = self
        capacityCollectionView.allowsMultipleSelection = false
        capacityCollectionView.allowsSelection = true
        
        capacityCollectionView.register(
            CapacityCollectionViewCell.self,
            forCellWithReuseIdentifier: "capacityCellID"
        )
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(
                width: collectionView.frame.width / 2 - 4,
                height: collectionView.frame.height - 4
            )
        case 1:
            return CGSize(
                width: collectionView.frame.width / 2 - 4,
                height: collectionView.frame.height - 4
            )
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0: colorSelectedCell = indexPath.row
        case 1: capacitySelectedCell = indexPath.row
        default: break
        }
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionViewCountResponse(collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0: 
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "colorCellID",
                for: indexPath
            ) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            
            let color = productDetailsViewModel.color[indexPath.row]
            let viewModel = ColorCollectionViewCellModel(color: color)
            if let selectedCell = colorSelectedCell, selectedCell == indexPath.row {
                cell.isSelected = true
            }
            
            cell.viewModel = viewModel
            
            return cell
        
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "capacityCellID",
                for: indexPath
            ) as? CapacityCollectionViewCell else { return UICollectionViewCell() }
            
            let capacity = productDetailsViewModel.capacity[indexPath.row]
            let viewModel = CapacityCollectionViewCellModel(capacity: capacity)
            if let selectedCell = capacitySelectedCell, selectedCell == indexPath.row {
                cell.isSelected = true
            }
            
            cell.viewModel = viewModel
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
