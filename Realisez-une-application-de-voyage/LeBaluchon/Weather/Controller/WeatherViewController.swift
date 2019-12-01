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
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            citiesSegmented.selectedSegmentTintColor = UIColor(named: "Jaune")!
        } else {
            citiesSegmented.tintColor = UIColor(named: "Jaune")!
        }
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
                
                let date = Date(timeIntervalSince1970: response.dt)
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.setLocalizedDateFormatFromTemplate("EEEEdMMMM")
                
                let formattedDate = dateFormatter.string(from: date)
                
                self.date.text = "\(formattedDate)"
                self.descriptionWeather.text = "\(response.weather[0].description)"
                self.currentTemperature.text = "\(response.main.temp)ºC"
                self.minTemperature.text = "\(response.main.temp_min)ºC"
                self.maxTemperature.text = "\(response.main.temp_max)ºC"
                self.humidity.text = "\(response.main.humidity)%"

            case let .failure(error):
                let alertVC = UIAlertController(title: "Erreur", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
}
