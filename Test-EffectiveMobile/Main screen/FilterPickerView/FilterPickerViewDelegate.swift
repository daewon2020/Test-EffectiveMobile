//
//  FilterPickerViewDelegate.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 06.09.2022.
//

import Foundation
import UIKit

final class FilterPickerViewDelegate: NSObject, UIPickerViewDelegate {
    private weak var delegate: MainScreenVCDelegateProtocol!
    private var barands: [String]
    private var prices: [String]
    private var sizes: [String]
    
    init(withDelegate delegate: MainScreenVC ) {
        self.barands = DataManager.shared.getBrands()
        self.prices = DataManager.shared.getPrice()
        self.sizes = DataManager.shared.getSize()
        self.delegate = delegate
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: return barands[row]
        case 1: return prices[row]
        case 2: return sizes[row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: delegate.selectedBrandForFilter(barands[row])
        case 1: delegate.selectedPriceForFilter(prices[row])
        case 2: delegate.selectedSizeForFilter(sizes[row])
        default: break
        }
    }
}
