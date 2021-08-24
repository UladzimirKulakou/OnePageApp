//
//  ImageCollectionViewCell.swift
//  OnePageApp
//
//  Created by Владимир  on 20.08.21.
//

import UIKit
import AlamofireImage
import Alamofire

enum State {
    case loading
    case loaded(image: UIImage)
}
class ImageCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var photoView: UIImageView!
    //
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        // Initialization code
    }
    func update(state: State) {
        switch state {
        case .loading:
            if !activityIndicator.isAnimating {
                activityIndicator.startAnimating()
            }
            photoView.image = nil
        case let .loaded(image: image):
            if activityIndicator.isAnimating {
                activityIndicator.stopAnimating()
            }
            photoView.image = image
        }
    }


}


