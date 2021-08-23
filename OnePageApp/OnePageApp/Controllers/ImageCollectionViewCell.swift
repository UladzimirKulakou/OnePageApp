//
//  ImageCollectionViewCell.swift
//  OnePageApp
//
//  Created by Владимир  on 20.08.21.
//

import UIKit
import AlamofireImage
import Alamofire

class ImageCollectionViewCell: UICollectionViewCell {

    let url = "https://loremflickr.com/200/200/"
    var cellIndex = 0

    @IBOutlet weak var photoView: UIImageView!
    //
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        // Initialization code
    }
    func fetchImsge() {
        AF.request(url).responseImage { [weak self] response in
            if case .success(let image) = response.result {
                self?.photoView.image = image
                self?.activityIndicator.stopAnimating()
                self?.cellIndex += 1
            }
        }
    }
    

}


