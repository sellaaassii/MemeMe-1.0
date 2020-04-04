//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Selasi Kudolo on 2020-04-03.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var sentMemeCollectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDeletgate = object as! AppDelegate
        return appDeletgate.memes
    }
    
    override func viewDidLoad() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let height = collectionView.frame.width / 2
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//
//          //Populate view controller with data from the selected item
//          detailController.villain = allVillains[(indexPath as NSIndexPath).row]
//
//          // Present the view controller using navigation
//          navigationController!.pushViewController(detailController, animated: true)

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeView", for: indexPath) as! MemeCollectionViewCell

        let meme = self.memes[(indexPath).row]
        print("IOBDFIODBFIOSDBFIOSBDFIOBSDIOFBSDIOFSD")
        print(meme.bottomText)
        
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return memes.count
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        sentMemeCollectionView.reloadData()
        self.reloadInputViews()
    }
}
