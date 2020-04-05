//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Selasi Kudolo on 2020-04-03.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet var sentMemeCollectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var createMemeButton: UIBarButtonItem!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDeletgate = object as! AppDelegate
        return appDeletgate.memes
    }
    
    override func viewDidLoad() {
        setupFlowLayout()
        navigationController?.navigationBar.topItem?.title = "Sent Memes"
    }
    
    func setupFlowLayout() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let height = sentMemeCollectionView.bounds.size.height / 4

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: height)
    }
    
    @IBAction func createMeme(_ sender: Any) {
        performSegue(withIdentifier: "createMeme", sender: sender)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeView", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath).row]
        
        cell.memeImageView.image = meme.memedImage

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sentMemeCollectionView!.reloadData()
    }
    
    

}
