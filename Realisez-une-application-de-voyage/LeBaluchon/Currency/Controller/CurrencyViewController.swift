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
        toggleActivityIndicator(shown: false)
          // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedGoButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)

        view.endEditing(true)
            
        guard let text = amountToExchange.text
            else {
                return
        }
        
        converter.convert(from: text) { (result) in
             self.toggleActivityIndicator(shown: false)
            print(result)
            
            switch result {
            case let .success(usdValue):
                //TODO: Managing round numbers
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                let usdCurrency = Locale(identifier: "en_US")
                formatter.locale = usdCurrency
                formatter.string(for: usdValue)

                self.amountExchanged.text = formatter.string(for: usdValue)
                
            case let .failure(error):
                let alertVC = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        goButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
}

