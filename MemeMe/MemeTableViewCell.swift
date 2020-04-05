//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Selasi Kudolo on 2020-04-04.
//  Copyright © 2020 Ewe Cat Productions. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    var memeText: String?
    var memeImage: UIImage?
    
    var memeTextLabel: UILabel = {
        var newLabel = UILabel()
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        newLabel.textAlignment = .center
        newLabel.contentMode = .scaleAspectFit
        return newLabel
    }()
    
    var memeImageView: UIImageView = {
        var newImageView = UIImageView()
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        newImageView.contentMode = .scaleAspectFit
        return newImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(memeTextLabel)
        self.addSubview(memeImageView)
        
        memeImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        memeImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        memeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        memeImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        memeImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        memeTextLabel.leftAnchor.constraint(equalTo: self.memeImageView.rightAnchor).isActive = true
        memeTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        memeTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        memeTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let memeText = memeText {
            memeTextLabel.text = memeText
        }

        if let meme = memeImage {
            memeImageView.image = meme
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
