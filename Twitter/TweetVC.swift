//
//  TweetVC.swift
//  Twitter
//
//  Created by Alex Paul on 3/11/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetVC: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweets(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print(error.localizedDescription)
                self.dismiss(animated: true, completion: nil)

            })
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}
