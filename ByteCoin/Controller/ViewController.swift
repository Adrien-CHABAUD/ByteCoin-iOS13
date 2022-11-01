//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        
        // Set the picker's datasource & delegate func
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    //MARK: - Picker Functions
    
    // Only one picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // There is as much rows than currencies
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // Retrieve the currency labels to be displayed
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Get the selected currency
        let currencySelected = coinManager.currencyArray[row]
        // Pass the currency to the getCoinPrice function
        coinManager.getCoinPrice(for: currencySelected)
    }
    
    //MARK: - Delegate functions
    
    func didUpdateCoin(currency: String, price: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currency
            self.currencyLabel.text = price
        }
    }
    
    func didFailWithEror(error: Error) {
        print(error)
    }

}

