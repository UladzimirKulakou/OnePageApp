//
//  ViewController.swift
//  OnePageApp
//
//  Created by Владимир  on 20.08.21.
//

import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController {

    var images = [UIImage]()
    var imageCount = 0
    let countCells = Preferences().countCells
    let offset: CGFloat = Preferences().offset
    let url = Preferences().url
    let cellId = Preferences().cellId

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func addOneImage(_ sender: UIBarButtonItem) {
        imageCount += 1
        self.collectionView.reloadData()
    }
    
    @IBAction func reloadImage(_ sender: Any) {
        self.images = []
        imageCount = 140
        self.collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCollectionViewCell

        cell.fetchImsge()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let hightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: hightCell - offset * 2)
    }


}

