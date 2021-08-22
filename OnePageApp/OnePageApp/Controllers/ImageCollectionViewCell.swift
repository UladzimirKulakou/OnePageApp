//
//  ImageCollectionViewCell.swift
//  OnePageApp
//
//  Created by Владимир  on 20.08.21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var photoView: UIImageView!
    //
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        // Initialization code
    }


}


