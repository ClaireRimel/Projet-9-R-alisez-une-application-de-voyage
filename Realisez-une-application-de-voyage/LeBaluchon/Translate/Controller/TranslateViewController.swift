//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by Claire on 16/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var outputTextView: UITextView!
    @IBOutlet var goButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let translation = Translation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedGoButton(_ sender: Any) {
        view.endEditing(true)
        
        translation.request(from: inputTextView.text) { (result) in            
            switch result {
            case let .success(translatedText):
                self.outputTextView.text = translatedText
            case let .failure(error):
                let alertVC = UIAlertController(title: "Erreur", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputTextView.resignFirstResponder()
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        goButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
}
