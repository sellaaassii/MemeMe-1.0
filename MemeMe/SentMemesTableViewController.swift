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
    
    @IBOutlet var sentMemeTableView: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDeletgate = object as! AppDelegate
        return appDeletgate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Sent Memes"
        sentMemeTableView.register(MemeTableViewCell.self, forCellReuseIdentifier: "MemeTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        var memeText: String = ""

        if meme.topText != "" {
            memeText = meme.topText
        }
        
        if meme.bottomText != "" {
            memeText += "....." + meme.bottomText
        }
        
        cell.memeImageView.image = meme.memedImage
        cell.memeText = memeText
        cell.layoutSubviews()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.sentMemeTableView!.reloadData()
    }

}
