//
//  ExchangeViewController.swift
//  LeBaluchon
//
//  Created by Claire on 16/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    let converter = CurrencyConverter()
    
    @IBOutlet weak var amountToExchange: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var amountExchanged: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        amountToExchange.delegate = self
        toggleActivityIndicator(shown: false)
        
        amountToExchange.text = "1"
        textFieldDidEndEditing(amountToExchange)
                
        tappedGoButton(UIButton())
    }
    
    @IBAction func tappedGoButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        
        view.endEditing(true)
        
        converter.convert(from: amountToExchange.text ?? "") { (result) in
            self.toggleActivityIndicator(shown: false)
            print(result)
            
            switch result {
            case let .success(usdValue):
                let value = self.convertDoubleToCurrency(amount: usdValue, locale: Locale(identifier: "en_US"))
                self.amountExchanged.text = value
                
            case let .failure(error):
                let alertVC = UIAlertController(title: "Erreur", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        amountToExchange.resignFirstResponder()
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        goButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    func convertDoubleToCurrency(amount: Double, locale: Locale) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let double = Double(text) {
            let value = convertDoubleToCurrency(amount: double, locale: Locale(identifier: "fr_FR"))
            textField.text = value
        }
    }
}
