//
//  TweetCellVC.swift
//  Twitter
//
//  Created by Alex Paul on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellVC: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
     
    @IBOutlet weak var retweet: UIButton!
    
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    var favorited:Bool = false
    var ttweetID = -1
    var retweeted: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoriteButton(_ sender: Any) {
        let toBeFavorited  = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweets(tweetID: ttweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print(error.localizedDescription)
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweets(tweetID: ttweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Something went wrong with favorites")
            })
        }
        
        
        
        
    }
    
    
    
    
    
    @IBAction func retweetButton(_ sender: Any) {
        
        TwitterAPICaller.client?.reTweets(tweetID: ttweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print(error.localizedDescription)
        })
        
        
    }
   
    
    
    func setRetweeted (_ isRetweeted:Bool){
        if (isRetweeted){
            retweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet.isEnabled = false
        }
        
        else {
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favoritesButton.tintColor = UIColor.red
        }
        else{
            favoritesButton.tintColor = UIColor.blue

        }
    }
    
    
    
    
}
