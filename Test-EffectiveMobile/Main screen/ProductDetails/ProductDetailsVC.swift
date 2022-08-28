//
//  ProductDetailsVC.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import UIKit
protocol ProductDetailsVCProtocol: AnyObject {
    
}

class ProductDetailsVC: UIViewController {

    var presenter: ProductDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK: - ProductDetailsVCProtocol

extension ProductDetailsVC: ProductDetailsVCProtocol {
    
}
