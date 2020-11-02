//
//  PhotoVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 30/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage
import JTSImageViewController

class PhotoVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblPageCount: UILabel!
    
    var imgUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgUrls.append("https://homepages.cae.wisc.edu/~ece533/images/airplane.png")
        imgUrls.append("https://homepages.cae.wisc.edu/~ece533/images/arctichare.png")
        imgUrls.append("https://homepages.cae.wisc.edu/~ece533/images/baboon.png")
        imgUrls.append("https://homepages.cae.wisc.edu/~ece533/images/frymire.png")
        imgUrls.append("https://homepages.cae.wisc.edu/~ece533/images/serrano.png")
        
        lblPageCount.text = String(format: "%i/%li", 1 , imgUrls.count)
    }
}

//MARK:- Button actions
extension PhotoVC{
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismissPopUpViewController()
    }
}

//MARK:- Collection View Methods
extension PhotoVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        imgCell.imageView.sd_setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQfSk2gzoEhClkwk9lx9a9a8q9EC9PGzSV3Tg&usqp=CAU"), completed: nil)
        return imgCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizze = CGSize(width: UIScreen.main.bounds.size.width - 64, height: UIScreen.main.bounds.size.height - 128)
        return sizze
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView.cellForItem(at: indexPath) as? PictureCell
        let imageInfo = JTSImageInfo()
        #if TRY_AN_ANIMATED_GIF
        imageInfo.imageURL = URL(string: "http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif")
        #else
        imageInfo.image = cell?.imageView.image
        #endif
        imageInfo.referenceRect = (cell?.imageView.frame)!
        imageInfo.referenceView = cell?.imageView.superview
        imageInfo.referenceContentMode = (cell?.imageView.contentMode)!
        imageInfo.referenceCornerRadius = (cell?.imageView.layer.cornerRadius)!
        let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: .image, backgroundStyle: .scaled)
        imageViewer?.show(from: self, transition: JTSImageViewControllerTransition.fromOriginalPosition)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = UIScreen.main.bounds.size.width - 64
        let fractionalPage = Float((collectionView.contentOffset.x / pageWidth))
        let page = Int(roundf(fractionalPage))
        lblPageCount.text = String(format: "%i/%li", page + 1, imgUrls.count)
    }
    
}
