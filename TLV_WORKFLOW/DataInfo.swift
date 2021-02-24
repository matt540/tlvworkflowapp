//
//  DataInfo.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 19/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataInfo{
    var seller = [Seller]()
    var shipSize = [ShipSize]()
    var shopData = [ShopData]()
    var productDetail = [ProductDetail]()
    var product = [Product]()
    var images = [Images]()
    var productDataDetail = [ProductDataDetail]()
    var editImageStore = [EditImageStore]()
    var editProduct = [EditProduct]()
    var id = 0
    var uniqueIdForProduct = 0
    var productDataDetailId = 0

    //MARK:- sellerData
    func createData(id:Int, pageno:Int, sellerData:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let studentsEntity = NSEntityDescription.entity(forEntityName: "Seller", in: managedContext)!
        let seller = Seller(entity: studentsEntity, insertInto: managedContext)
        seller.id = Int16(id)
        seller.pageno = Int16(pageno)
        seller.seller = sellerData
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func isSellerPageExists(pageno :Int) -> Bool{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Seller> = Seller.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "pageno = %@", "\(pageno)")
            do{
                seller = try managedContext.fetch(fetchRequest)
            }catch{
                print("Failed")
            }
            return seller.count > 0
        }
    func retriveData(pageno: Int) -> [Seller]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Seller> = Seller.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pageno = %@", "\(Int16(pageno))")
        do{
            seller = try managedContext.fetch(fetchRequest)
            return seller
        }catch{
            print("Failed")
            return []
        }
    }
    func deleteSellerData(pageno: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Seller> = Seller.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pageno = %@", "\(pageno)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            for dataTodelete in data
            {
                let deleteData = dataTodelete as NSManagedObject
                managedContext.delete(deleteData)
            }
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    
    //MARK:- ShipSize Data
    func createDataShipSize(shipSizeData:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let shipSizeEntity = NSEntityDescription.entity(forEntityName: "ShipSize", in: managedContext)!
        let shipSize = ShipSize(entity: shipSizeEntity, insertInto: managedContext)
        shipSize.id = Int16(id)
        shipSize.shipsize = shipSizeData
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveDataShipSize() -> [ShipSize]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShipSize> = ShipSize.fetchRequest()
        do{
            shipSize = try managedContext.fetch(fetchRequest)
            return shipSize
        }catch{
            print("Failed")
            return []
        }
    }
    func updateDataShipSize(id:Int, shipSizeData:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShipSize> = ShipSize.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        do{
            shipSize = try managedContext.fetch(fetchRequest)
            if shipSize.count != 0{
                let updateObject = shipSize[0] as NSManagedObject
                updateObject.setValue(shipSizeData, forKey: "shipsize")
                try managedContext.save()
            }
        }catch{
            print("Failed")
        }
    }
    
    //MARK:- ShopData
    func createDataShop(pickLocation:String, sellerData: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let shopEntity = NSEntityDescription.entity(forEntityName: "ShopData", in: managedContext)!
        let shop = ShopData(entity: shopEntity, insertInto: managedContext)
        shop.id = Int16(id)
        shop.pick_location = pickLocation
        shop.seller_data = sellerData
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveDataShop() -> [ShopData]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShopData> = ShopData.fetchRequest()
        do{
            shopData = try managedContext.fetch(fetchRequest)
            return shopData
        }catch{
            print("Failed")
            return []
        }
    }
    func updateDataShop(id:Int, pickLocation:String, sellerData: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShopData> = ShopData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        do{
            shopData = try managedContext.fetch(fetchRequest)
            if shopData.count != 0{
                let updateObject = shopData[0] as NSManagedObject
                updateObject.setValue(pickLocation, forKey: "pick_location")
                updateObject.setValue(sellerData, forKey: "seller_data")
                try managedContext.save()
            }
        }catch{
            print("Failed")
        }
    }
    
    //MARK:- Product Details Data
    func createProductDetailData(id: Int, sellerId: Int, pageno:Int, product: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let productDetailEntity = NSEntityDescription.entity(forEntityName: "ProductDetail", in: managedContext)!
        let productDetail = ProductDetail(entity: productDetailEntity, insertInto: managedContext)
        productDetail.id = Int16(id)
        productDetail.seller_id = Int16(sellerId)
        productDetail.pageno = Int16(pageno)
        productDetail.product_detail = product
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveProductDetailData(seller_id: Int) -> [ProductDetail]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductDetail> = ProductDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "seller_id = %@", "\(Int16(seller_id))")
        do{
            productDetail = try managedContext.fetch(fetchRequest)
            return productDetail
        }catch{
            print("Failed")
            return []
        }
    }
    func isProductDetailsExists(sellerid :Int) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductDetail> = ProductDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "seller_id = %@", "\(sellerid)")
        do{
            productDetail = try managedContext.fetch(fetchRequest)
        }catch{
            print("Failed")
        }
        return productDetail.count > 0
    }
    func deleteProductDetailsData(sellerid: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductDetail> = ProductDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "seller_id = %@", "\(sellerid)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            for dataTodelete in data
            {
                let deleteData = dataTodelete as NSManagedObject
                managedContext.delete(deleteData)
            }
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    
    //MARK:- Add product Data
    func createAddProductData(product_detail: String) {
        let availData = retriveAddProductData()
        for data in availData{
            if data.id == uniqueIdForProduct {
                uniqueIdForProduct += 1
            }
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)!
        let product = Product(entity: productEntity, insertInto: managedContext)
        product.id = Int16(uniqueIdForProduct)
        product.product_detail = product_detail
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveAddProductData() -> [Product]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do{
            product = try managedContext.fetch(fetchRequest)
            return product
        }catch{
            print("Failed")
            return []
        }
    }
    func deleteAddProductData(id: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            let deleteData = data[0] as NSManagedObject
            managedContext.delete(deleteData)
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    
    //MARK:- Image Add Product
    func createImageData(image_url: String) {
        let availData = retriveAddProductData()
        let img_id = availData.count - 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let imageEntity = NSEntityDescription.entity(forEntityName: "Images", in: managedContext)!
        let imageDetail = Images(entity: imageEntity, insertInto: managedContext)
        imageDetail.p_id = Int16(img_id)
        imageDetail.image_url = image_url
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveImageData() -> [Images]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Images> = Images.fetchRequest()
        do{
            images = try managedContext.fetch(fetchRequest)
            return images
        }catch{
            print("Failed")
            return []
        }
    }
    func deleteImageData(image_url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Images> = Images.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "image_url = %@", "\(image_url)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            for dataTodelete in data
            {
                let deleteData = dataTodelete as NSManagedObject
                managedContext.delete(deleteData)
            }
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    
    //MARK:- Offline Edit Product Data
    func createProductData(productId:Int, productData:String){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let managedContext = appDelegate.persistentContainer.viewContext
           let productDataEntity = NSEntityDescription.entity(forEntityName: "ProductDataDetail", in: managedContext)!
           let product = ProductDataDetail(entity: productDataEntity, insertInto: managedContext)
            let availData = retriveProductDataDetails()
            for data in availData{
                if data.id == productDataDetailId {
                    productDataDetailId += 1
                }
            }
           product.id = Int16(productDataDetailId)
           product.product_id = Int16(productId)
           product.product_data = productData
           do{
               try managedContext.save()
           }catch let error as NSError{
               print("Could not save.\(error), \(error.userInfo)")
           }
       }
       func isProductDataDetailExists(productId :Int) -> Bool{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
               let managedContext = appDelegate.persistentContainer.viewContext
               let fetchRequest: NSFetchRequest<ProductDataDetail> = ProductDataDetail.fetchRequest()
               fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(productId)")
               do{
                   productDataDetail = try managedContext.fetch(fetchRequest)
               }catch{
                   print("Failed")
               }
               return productDataDetail.count > 0
           }
       func retriveProductDataDetails() -> [ProductDataDetail]{
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<ProductDataDetail> = ProductDataDetail.fetchRequest()
           do{
               productDataDetail = try managedContext.fetch(fetchRequest)
               return productDataDetail
           }catch{
               print("Failed")
               return []
           }
       }
       func deleteProductDataDetail(productId: Int){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<ProductDataDetail> = ProductDataDetail.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(productId)")
           do {
               let data = try managedContext.fetch(fetchRequest)
               let deleteData = data[0] as NSManagedObject
               managedContext.delete(deleteData)
               do {
                   try managedContext.save()
               } catch  {
                   print("error while saving data")
               }
               
           } catch  {
               print("failed while deleting")
           }
       }
    
    //MARK:- Edit image Data
    func createEditImageData(productId:Int, imageData: Data, status: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let imageEntity = NSEntityDescription.entity(forEntityName: "EditImageStore", in: managedContext)!
        let imageDetail = EditImageStore(entity: imageEntity, insertInto: managedContext)
        imageDetail.product_id = Int16(productId)
        imageDetail.imagedata = imageData
        imageDetail.status = Int16(status)
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func retriveEditImageData(productId: Int) -> [EditImageStore]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditImageStore> = EditImageStore.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(productId)")
        do{
            editImageStore = try managedContext.fetch(fetchRequest)
            return editImageStore
        }catch{
            print("Failed")
            return []
        }
    }
    func deleteEditImageData(imageData: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditImageStore> = EditImageStore.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "imagedata = %@", "\(imageData)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            for dataTodelete in data
            {
                if dataTodelete.imagedata == imageData{
                    let deleteData = dataTodelete as NSManagedObject
                    managedContext.delete(deleteData)
                    break
                }
            }
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
        } catch  {
            print("failed while deleting")
        }
    }
    func deleteEditImageDataStatus() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditImageStore> = EditImageStore.fetchRequest()
        do {
            let data = try managedContext.fetch(fetchRequest)
            for dataTodelete in data
            {
                if dataTodelete.status == 0{
                    let deleteData = dataTodelete as NSManagedObject
                    managedContext.delete(deleteData)
                }
            }
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    func deleteEditImageDataId(id: Int) {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<EditImageStore> = EditImageStore.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(id)")
           do {
               let data = try managedContext.fetch(fetchRequest)
               for dataTodelete in data
               {
                   let deleteData = dataTodelete as NSManagedObject
                   managedContext.delete(deleteData)
               }
               do {
                   try managedContext.save()
               } catch  {
                   print("error while saving data")
               }
               
           } catch  {
               print("failed while deleting")
           }
       }
    func updateEditImageDataStatus() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<EditImageStore> = EditImageStore.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "status = %@", "0")
           do{
               editImageStore = try managedContext.fetch(fetchRequest)
               if editImageStore.count != 0{
                   let updateObject = editImageStore[0] as NSManagedObject
                   updateObject.setValue(1, forKey: "status")
                   try managedContext.save()
               }
           }catch{
               print("Failed")
           }
       }
    
    //MARK:- Edit Product Data save
    func createEditProductData(productId:Int, productData: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let editProductEntity = NSEntityDescription.entity(forEntityName: "EditProduct", in: managedContext)!
        let editProduct = EditProduct(entity: editProductEntity, insertInto: managedContext)
        editProduct.product_id = Int16(productId)
        editProduct.productdata = productData
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save.\(error), \(error.userInfo)")
        }
    }
    func isEditProductDataExists(productId :Int) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditProduct> = EditProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(productId)")
        do{
            editProduct = try managedContext.fetch(fetchRequest)
        }catch{
            print("Failed")
        }
        return editProduct.count > 0
    }
    func retriveEditProductData() -> [EditProduct]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditProduct> = EditProduct.fetchRequest()
        do{
            editProduct = try managedContext.fetch(fetchRequest)
            return editProduct
        }catch{
            print("Failed")
            return []
        }
    }
    func deleteEditProductData(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditProduct> = EditProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(id)")
        do {
            let data = try managedContext.fetch(fetchRequest)
            let deleteData = data[0] as NSManagedObject
            managedContext.delete(deleteData)
            do {
                try managedContext.save()
            } catch  {
                print("error while saving data")
            }
            
        } catch  {
            print("failed while deleting")
        }
    }
    func updateEditProductData(id: Int,productData: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EditProduct> = EditProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(id)")
        do{
            editProduct = try managedContext.fetch(fetchRequest)
            if editProduct.count != 0{
                let updateObject = editProduct[0] as NSManagedObject
                updateObject.setValue(productData, forKey: "productData")
                try managedContext.save()
            }
        }catch{
            print("Failed")
        }
    }
}
