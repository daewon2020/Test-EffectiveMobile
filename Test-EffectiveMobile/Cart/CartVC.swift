//
//  CartVC.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 02.09.2022.
//

import UIKit

protocol CartVCProtocol: AnyObject {
    func dataDidRecieve(viewModel: CartModel)
    func setTotalPriceText(price: Double)
    func setDeliveryText(delivery: String)
    func countDidChange(at indexPath: IndexPath, with newValue: Int)
    func plusButtonTapped(at cell: UITableViewCell)
    func minusButtonTapped(at cell: UITableViewCell)
    func deleteButtonTapped(at cell: UITableViewCell)
}

final class CartVC: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var backgroundSheetView: UIView!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    private var viewModel: CartModel? {
        didSet {
            cartTableView.reloadData()
        }
    }
    
    private var presenter: CartPresenterProrocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CartPresenter(view: self)
        
        setupTableView()
        
        backgroundSheetView.layer.cornerRadius = 20
        backgroundSheetView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
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
        
        let cartButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
        cartButtonView.backgroundColor = UIColor(hex: "#FF6E4E")
        cartButtonView.layer.cornerRadius = 10

        let cartImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 14))
        cartImageView.image = UIImage(named: "geo")
        cartImageView.contentMode = .scaleAspectFit
        cartImageView.tintColor = .white
        cartImageView.backgroundColor = .clear
        cartButtonView.addSubview(cartImageView)
        cartImageView.center = cartButtonView.center
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButtonView)
        
        presenter.viewDidLoad()
    }
    
    @objc private func backButtonTaped() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - UITableViewDataSource

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.basket.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCellID", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        if let viewModel = viewModel {
            cell.parentView = self
            cell.viewModel = viewModel.basket[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

extension CartVC {
    func setupTableView() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(
            UINib(nibName: "CartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "cartCellID"
        )
    }
}

//MARK: - CartVCProtocol

extension CartVC: CartVCProtocol {
    func dataDidRecieve(viewModel: CartModel) {
        self.viewModel = viewModel
    }
    
    func setTotalPriceText(price: Double) {
        totalLabel.text = "\(price)"
    }
    
    func setDeliveryText(delivery: String) {
        deliveryLabel.text = delivery
    }
    
    func countDidChange(at indexPath: IndexPath, with newValue: Int) {
        viewModel?.basket[indexPath.row].count = newValue
        cartTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func plusButtonTapped(at cell: UITableViewCell) {
        if let indexPath = cartTableView.indexPath(for: cell) {
            presenter.plusButtonTapped(at: indexPath)
        }
    }
    
    func minusButtonTapped(at cell: UITableViewCell) {
        if let indexPath = cartTableView.indexPath(for: cell) {
            presenter.minusButtonTapped(at: indexPath)
        }
    }
    
    func deleteButtonTapped(at cell: UITableViewCell) {
        if let indexPath = cartTableView.indexPath(for: cell) {
            presenter.deleteButtonTapped(at: indexPath)
        }
    }
}
