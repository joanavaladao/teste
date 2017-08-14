//
//  ViewController.swift
//  teste
//
//  Created by Joana Valadao on 12/08/17.
//  Copyright © 2017 Joana Bittencourt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(_ sender: UIButton) {
        
        let requestURL: NSURL = NSURL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                DispatchQueue.main.async {
                    //self.text.text = data?.description
                    if let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        var textShow = ""
                        for case let result in (json?["orders"] as? [[String: Any]])!{
                            textShow += (result["email"] as? String)!.description + "\n"
                        }
                        self.text.text = textShow
                    }
                    
                    
                }
            } else  {
                print("Failed")
            }
        }
        task.resume()
//        text.text = task.value(forKey: "email") as! String
        
    }

}

