//
//  HomeVC.swift
//  Twitter
//
//  Created by Alex Paul on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberTweet: Int!
    let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
   
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        loadMoreTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    
    @objc func loadTweet(){
        numberTweet = 20
        let myParams = ["count":numberTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })
    }
    
    
    
    func loadMoreTweets(){
        numberTweet = numberTweet + 20
        let myParams = ["count":numberTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })
        
        
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion:nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellVC
        let user  = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url"]as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data{
            cell.profileImage.image = UIImage(data: imageData)
        }
        return cell
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    
}
