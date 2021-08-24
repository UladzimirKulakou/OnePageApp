//
//  ViewController.swift
//  OnePageApp
//
//  Created by Владимир  on 20.08.21.
//

import UIKit
import Alamofire
//import AlamofireImage

class Downloader {

    class func downloadImageWithURL(_ url: String) -> UIImage! {

        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {
    var indexPaths = [IndexPath]()

    var data = [State]()
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
        data.append(.loading)
        let index = data.endIndex - 1
        self.collectionView.reloadData()

        AF.request(self.url).responseImage(queue: .global(qos: .utility)) { [unowned self] response in
            if case .success(let image) = response.result {
                DispatchQueue.main.async() { self.data[index] = .loaded(image: image)
                self.collectionView.reloadItems(at: [.init(item: index, section: 0)])
                }
            }
        }
    }

    @IBAction func reloadImage(_ sender: Any) {
        data = Array(repeating: .loading, count: 140)
        
        self.collectionView.reloadData()
        
        (0..<140).forEach { index in
           
            AF.request(self.url).responseImage(queue: .global(qos: .utility)) { [unowned self] response in
                if case .success(let image) = response.result {
                    DispatchQueue.main.async() { self.data[index] = .loaded(image: image)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCollectionViewCell

        cell.update(state: data[indexPath.row])
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

