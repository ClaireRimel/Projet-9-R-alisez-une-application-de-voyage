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
    var citySelected: String = ""
    
    @IBOutlet weak var citiesSegmented: UISegmentedControl!
    @IBOutlet weak var responseWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySwitched(citiesSegmented)

    }
    
    @IBAction func citySwitched(_ sender: UISegmentedControl) {
        switch citiesSegmented.selectedSegmentIndex {
              case 0:
                  citySelected = "nantes,fr"
              case 1:
                  citySelected = "new york,us"
              default:
                  citySelected = "nantes,fr"
              }
        
        request.request(from: citySelected) { (result) in
            switch result {
            case let .success(response):
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                dateFormatter.timeStyle = .none
                
                let date = Date(timeIntervalSinceReferenceDate: response.dt)
                dateFormatter.locale = Locale(identifier: "fr_FR")
                let formattedDate = dateFormatter.string(from: date)
                
                print(formattedDate)
                print(response)
                self.responseWeatherLabel.text = """
                Aujourd'hui \(formattedDate), \( response.dt) il fait \(response.main.temp)ºC
                
                le temps est \(response.weather[0].description)
                
                """
            case let .failure(error):
                let alertVC = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
}

