//
//  ViewController.swift
//  Whats The Weather
//
//  Created by SHS on 1/1/19.
//  Copyright © 2019 SHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    var notCORRECT = false
    
    //Para esconder el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    @IBAction func getWeather(_ sender: AnyObject) {
        
        let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")!
        
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
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[3].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "º")
                                
                                print (message)
                                
                            }
                            
                        }
                    }
                }
                
                if message == "" {
                    
                    message = "The weather there could not be found. Please try again."
                    
                    self.notCORRECT = true
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.resultLabel.text = message
                    
                    if self.notCORRECT == true {
                        
                        self.resultLabel.textColor = UIColor.red
                        
                        self.notCORRECT = false
                        
                    } else {
                        
                        self.resultLabel.textColor = UIColor.black
                    
                    }
                    
                    
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
