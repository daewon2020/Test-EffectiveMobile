//
//  CartVC.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 02.09.2022.
//

import UIKit

protocol CartVCProtocol {
    
}

class CartVC: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var backgroundSheetView: UIView!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSheetView.layer.cornerRadius = 20
        backgroundSheetView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner]
    }
    



}
