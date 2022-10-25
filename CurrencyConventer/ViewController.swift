//
//  ViewController.swift
//  CurrencyConventer
//
//  Created by ertugrul on 25.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func clikedGetRates(_ sender: Any) {
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                
                if data != nil{
                    do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                
                                if let tr = rates["TRY"]{
                                    self.tryLabel.text = "TRY : \(tr)"
                                }
                                if let usd = rates["USD"]{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let cad = rates["CAD"]{
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let chf = rates["CHF"]{
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let gbp = rates["GBP"]{
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                if let jpy = rates["JPY"]{
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                            }
                                    
                            
                        }
                    }
                    catch{
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
}

