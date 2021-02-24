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
    
    var imgUrls: [AddProductProductPendingImage]?
    var isEditView: Bool = false
    var addImageData: [Any]?
    var editImageData: [EditImageStore]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEditView{
            if GlobalFunction.isNetworkReachable(){
                lblPageCount.text = String(format: "%i/%li", 1 , imgUrls?.count ?? 0)
            }else{
                lblPageCount.text = String(format: "%i/%li", 1 , editImageData?.count ?? 0)
            }
        }else{
            if GlobalFunction.isNetworkReachable(){
                lblPageCount.text = String(format: "%i/%li", 1 , imgUrls?.count ?? 0)
            }else{
                lblPageCount.text = String(format: "%i/%li", 1 , addImageData?.count ?? 0)
            }
        }
    }
}

//MARK:- Button actions
extension PhotoVC{
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismissPopUp()
    }
}

//MARK:- Collection View Methods
extension PhotoVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditView{
            if GlobalFunction.isNetworkReachable(){
                return imgUrls?.count ?? 0
            }else{
                return editImageData?.count ?? 0
            }
        }else{
            if GlobalFunction.isNetworkReachable(){
                return imgUrls?.count ?? 0
            }else{
                return addImageData?.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        if isEditView{
            if GlobalFunction.isNetworkReachable(){
                let imgUrl = image_base_url + (imgUrls?[indexPath.row].name)!
                imgCell.imageView.sd_setImage(with: URL(string: imgUrl), completed: nil)
            }else{
                let image = UIImage(data: (editImageData?[indexPath.row].imagedata!)!)
                imgCell.imageView.image = image
            }
        }else{
            if GlobalFunction.isNetworkReachable(){
                let imgUrl = image_base_url + (imgUrls?[indexPath.row].name)!
                imgCell.imageView.sd_setImage(with: URL(string: imgUrl), completed: nil)
            }else{
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                var writableDBPath: String? = nil
                writableDBPath = URL(fileURLWithPath: documentsDirectory.path).appendingPathComponent(addImageData![indexPath.item] as! String).path
                let pngData = NSData(contentsOfFile: writableDBPath ?? "") as Data?
                var image: UIImage? = nil
                if let pngData = pngData {
                    image = UIImage(data: pngData)
                }
                imgCell.imageView.image = image
            }
        }
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
        if isEditView{
            if GlobalFunction.isNetworkReachable(){
                lblPageCount.text = String(format: "%i/%li", page + 1 , imgUrls?.count ?? 0)
            }else{
                lblPageCount.text = String(format: "%i/%li", page + 1 , editImageData?.count ?? 0)
            }
        }else{
            if GlobalFunction.isNetworkReachable(){
                lblPageCount.text = String(format: "%i/%li", page + 1 , imgUrls?.count ?? 0)
            }else{
                lblPageCount.text = String(format: "%i/%li", page + 1 , addImageData?.count ?? 0)
            }
        }
    }
    
}
