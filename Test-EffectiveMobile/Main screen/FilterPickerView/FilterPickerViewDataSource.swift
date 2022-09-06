//
//  FilterPickerViewDataSource.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 06.09.2022.
//

import Foundation
import UIKit

final class FilterPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private var barands: [String]
    private var prices: [String]
    private var sizes: [String]
    
    override init() {
        self.barands = DataManager.shared.getBrands()
        self.prices = DataManager.shared.getPrice()
        self.sizes = DataManager.shared.getSize()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: return barands.count
        case 1: return prices.count
        case 2: return sizes.count
        default: return 0
        }
    }
}
