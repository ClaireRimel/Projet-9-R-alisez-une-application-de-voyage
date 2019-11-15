//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Claire on 16/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    let request = Weather()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        request.request { (result) in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                break
            
            }
        }
    }


}

