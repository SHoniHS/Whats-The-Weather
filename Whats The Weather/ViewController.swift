//
//  ViewController.swift
//  Whats The Weather
//
//  Created by SHS on 1/1/19.
//  Copyright © 2019 SHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    @IBAction func getWeather(_ sender: AnyObject) {
        
        let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text! + "/forecasts/latest")!
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var message = ""
            
            if error != nil {
                
                print (error as Any)
                
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 0 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[3].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 0 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "º")
                                
                                print (message)
                                
                            }
                            
                        }
                    }
                }
                
                if message == "" {
                    
                    message = "The weather there could not be found. Please try again until you select London..."
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.resultLabel.text = message
                    
                })
                
            }
        }
        
        task.resume()
        
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        }

}
