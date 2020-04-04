//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Selasi Kudolo on 2020-04-03.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDeletgate = object as! AppDelegate
        return appDeletgate.memes
    }
    @IBOutlet var sentMemeTableView: UITableView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        
       // cell.imageView?.frame  =
        cell.imageView?.image  = meme.memedImage
        cell.largeContentTitle = meme.topText + "....." + meme.bottomText
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
        self.sentMemeTableView.reloadData()
    }
}
