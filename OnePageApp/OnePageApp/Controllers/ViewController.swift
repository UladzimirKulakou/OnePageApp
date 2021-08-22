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
    let countCells = 7
    let offset: CGFloat = 2.0
    let url = UrlImage.imageUrl
 
    let cellId = "cellImage"
    @IBOutlet weak var collectionView: UICollectionView!



    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self




    }




    @IBAction func addOneImage(_ sender: UIBarButtonItem) {
        
        AF.request(url).responseImage { [weak self] response in
            debugPrint(response)


//            print(response.request)
//            print(response.response)
            debugPrint(response.result)

            if case .success(let image) = response.result {

                self?.images.append(image)

                print("image downloaded: \(image)")
                self?.collectionView.reloadData()
            }
        }



        //  images.append = UIImage(named: "image0")
    }

    @IBAction func reloadImage(_ sender: Any) {
        self.images = []
        self.collectionView.reloadData()
        for _ in 0...139 {
            AF.request("https://loremflickr.com/200/200/").responseImage { response in
                debugPrint(response)

//                print(response.request)
//                print(response.response)
                debugPrint(response.result)

                if case .success(let image) = response.result {
                    self.images.append(image)
                    print("image downloaded: \(image)")
                    self.collectionView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCollectionViewCell

        let image = images[indexPath.item]
        cell.photoView.image = image

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
