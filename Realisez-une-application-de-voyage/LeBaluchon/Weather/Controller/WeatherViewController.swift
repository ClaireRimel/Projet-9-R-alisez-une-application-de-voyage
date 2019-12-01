//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Claire on 16/10/2019.
//  Copyright © 2019 Claire Sivadier. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let weatherModel = Weather()
    
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
        
        // This function is called in viewDidLoad to ask the model the weather information of the current selected city. By default, the index is 0, which in the model coresponds to Nantes.
        citySwitched(citiesSegmented)
    }
    
    @IBAction func citySwitched(_ sender: UISegmentedControl) {
        weatherModel.request(from: citiesSegmented.selectedSegmentIndex) { (result) in
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
                self.currentTemperature.text = "\(response.main.temp)ºC"
                self.minTemperature.text = "\(response.main.temp_min)ºC"
                self.maxTemperature.text = "\(response.main.temp_max)ºC"
                self.humidity.text = "\(response.main.humidity)%"
                
                // Use of type safe first API in case of the weather array is empty, displaying a default text on that case
                if let description = response.weather.first?.description {
                    self.descriptionWeather.text = description
                } else {
                    self.descriptionWeather.text = "pas de données serveur"
                }

            case let .failure(error):
                let alertVC = UIAlertController(title: "Erreur", message: error.message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
}
