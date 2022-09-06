//
//  ProductDetailsVC.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import UIKit
protocol ProductDetailsVCProtocol: AnyObject {
    func productDetailsDidRecieve(_ viewModel: ProductDetailsModel)
    func setProductHeaderParams(title: String)
    func setIsFavoriteButtonHidden(to condition: Bool)
}

final class ProductDetailsVC: UIViewController {
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var capacityCollectionView: UICollectionView!
    @IBOutlet weak var paramCollectionView: UICollectionView!
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var ratingCollectionView: UICollectionView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productParamView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIImageView!
    
    private var productDetailsViewModel: ProductDetailsModel!
    private var colorSelectedCell: Int? = nil
    private var capacitySelectedCell: Int? = nil
    private var tabSelectedCell = 0
    private var imageSelectedCell = 0
    
    var presenter: ProductDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionViews()
        
        let backButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
        backButtonView.backgroundColor = UIColor(hex: "#010035")
        backButtonView.layer.cornerRadius = 10

        let backwardImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 14))
        backwardImageView.image = UIImage(systemName: "chevron.left")
        backwardImageView.contentMode = .scaleAspectFit
        backwardImageView.tintColor = .white
        backwardImageView.backgroundColor = .clear
        backButtonView.addSubview(backwardImageView)
        backwardImageView.center = backButtonView.center
        
        let customBackButton = UIBarButtonItem(customView: backButtonView)
        navigationItem.leftBarButtonItem = customBackButton
        backButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTaped)))
        title = "Product details"
        
        let cartButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
        cartButtonView.backgroundColor = UIColor(hex: "#FF6E4E")
        cartButtonView.layer.cornerRadius = 10

        let cartImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 14))
        cartImageView.image = UIImage(named: "cart")
        cartImageView.contentMode = .scaleAspectFit
        cartImageView.tintColor = .white
        cartImageView.backgroundColor = .clear
        cartButtonView.addSubview(cartImageView)
        cartImageView.center = cartButtonView.center
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButtonView)
        cartButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cartButtonTaped)))
        presenter.viewDidLoad()
    }
    
    @objc private func backButtonTaped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cartButtonTaped() {
        performSegue(withIdentifier: "cartID", sender: nil)
    }
}


//MARK: - ProductDetailsVCProtocol

extension ProductDetailsVC: ProductDetailsVCProtocol {
    func productDetailsDidRecieve(_ viewModel: ProductDetailsModel) {
        productDetailsViewModel = viewModel
        colorCollectionView.reloadData()
        capacityCollectionView.reloadData()
        paramCollectionView.reloadData()
        tabCollectionView.reloadData()
        carouselCollectionView.reloadData()
        ratingCollectionView.reloadData()
    }
    
    func setProductHeaderParams(title: String) {
        productTitleLabel.text = title
    }
    
    func setIsFavoriteButtonHidden(to condition: Bool) {
        isFavoriteButton.isHidden = condition
    }
    
}

//MARK: - Private functions

extension ProductDetailsVC {
    private func setupUI() {
        productParamView.layer.cornerRadius = 30
        productParamView.layer.shadowColor = UIColor(hex: "#374E88")?.cgColor
        productParamView.layer.shadowRadius = 10
        productParamView.layer.shadowOpacity = 0.16
        productParamView.layer.shadowOffset = CGSize(width: 0, height: -5)
        productParamView.clipsToBounds = false
        addToCartButton.layer.cornerRadius = 10
        productParamView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
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
        
        paramCollectionView.delegate = self
        paramCollectionView.dataSource = self
        paramCollectionView.allowsMultipleSelection = false
        paramCollectionView.allowsSelection = false
        
        paramCollectionView.register(
            ProductParamCollectionViewCell.self,
            forCellWithReuseIdentifier: "paramsCellID"
        )
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        tabCollectionView.allowsMultipleSelection = false
        tabCollectionView.allowsSelection = true

        tabCollectionView.register(
            ParamTabsCollectionViewCell.self,
            forCellWithReuseIdentifier: "tabCellID"
        )
        
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.allowsMultipleSelection = false
        carouselCollectionView.allowsSelection = true

        carouselCollectionView.register(
            CarouselCollectionViewCell.self,
            forCellWithReuseIdentifier: "carouselCellID"
        )
        
        ratingCollectionView.delegate = self
        ratingCollectionView.dataSource = self
        ratingCollectionView.allowsMultipleSelection = false
        ratingCollectionView.allowsSelection = false

        ratingCollectionView.register(
            RatingCollectionViewCell.self,
            forCellWithReuseIdentifier: "ratingCellID"
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
                height: collectionView.frame.height/2
            )
        case 2:
            return CGSize(
                width: collectionView.frame.width / 4,
                height: collectionView.frame.height
            )
        case 3: return CGSize(
            width: collectionView.frame.width / 3,
            height: collectionView.frame.height
        )
        case 4: return CGSize(
            width: collectionView.frame.width / 1.2 - 20,
            height: collectionView.frame.height - 30
        )
        case 5:
            return CGSize(
            width: collectionView.frame.height,
            height: collectionView.frame.height
        )
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0: colorSelectedCell = indexPath.row
        case 1: capacitySelectedCell = indexPath.row
        case 3: tabSelectedCell = indexPath.row
        case 4: return
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
        
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "paramsCellID",
                for: indexPath
            ) as? ProductParamCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.row {
            case 0 :
                cell.viewModel = ProductParamCollectionViewCellModel(
                    title: productDetailsViewModel.CPU,
                    image: "processor"
                )
            case 1 :
                cell.viewModel = ProductParamCollectionViewCellModel(
                    title: productDetailsViewModel.camera,
                    image: "camera"
                )
            case 2 :
                cell.viewModel = ProductParamCollectionViewCellModel(
                    title: productDetailsViewModel.ssd,
                    image: "memory"
                )
            case 3 :
                cell.viewModel = ProductParamCollectionViewCellModel(
                    title: productDetailsViewModel.sd,
                    image: "storage"
                )
            default:
                break
            }
            
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "tabCellID",
                for: indexPath
            ) as? ParamTabsCollectionViewCell else { return UICollectionViewCell() }
            
            let tabTitle = presenter.tabsResponseForCell(at: indexPath)
            let viewModel = ParamTabsCollectionViewCellModel(title: tabTitle)
            if tabSelectedCell == indexPath.row {
                cell.isSelected = true
            }
            
            cell.viewModel = viewModel
        
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "carouselCellID",
                for: indexPath
            ) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
            
            let image = productDetailsViewModel.images[indexPath.row]
            let viewModel = CarouselCollectionViewCellModel(image: image)
            if imageSelectedCell == indexPath.row {
                cell.isSelected = true
            }
            
            cell.viewModel = viewModel
            
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ratingCellID",
                for: indexPath
            ) as? RatingCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        imageSelectedCell = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        carouselCollectionView.reloadData()
    }
}
