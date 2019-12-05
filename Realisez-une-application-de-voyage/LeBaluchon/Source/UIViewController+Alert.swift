//
//  UIViewController+Alert.swift
//  LeBaluchon
//
//  Created by Claire on 05/12/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentUIAlert(message: String) {
        
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
