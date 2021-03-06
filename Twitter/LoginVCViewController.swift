//
//  LoginVCViewController.swift
//  Twitter
//
//  Created by Alex Paul on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController {

    
    var url = "https://api.twitter.com/oauth/request_token"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginName", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
   }
    
    
    
     @IBAction func loginButton(_ sender: Any) {
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginName", sender: self)
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })
     }
    
    
    
    
    
    

}
