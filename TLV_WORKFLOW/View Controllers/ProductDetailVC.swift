//
//  ProductDetailVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 28/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailVC: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnRadioArchive: UIButton!
    @IBOutlet weak var btnRadioDelete: UIButton!
    @IBOutlet weak var btnRadioSubmit: UIButton!
    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tblProductDetail: UITableView!
    @IBOutlet var productDetailCollectionView: UICollectionView!
    
    var pageCount: Int!
    var searchText = ""
    var sellerDetail: SellerListData?
    var productArray: [ProductData] = []
    var arrayDeleteIds: [Int] = []
    var arrayArchiveIds: [Int] = []
    var arraySubmitIds: [Int] = []
    var refreshControl = UIRefreshControl()
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    var tempPageCount = 1
    var productIds = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(productDataReload(notification:)), name: .productDataReload, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editProductDataSave(notification:)), name: .editProductSave, object: nil)
        notificationCenter = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pageCount = 1
        btnPrevious.isHidden = true
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        tblProductDetail.addSubview(refreshControl)
        DataInfo().deleteEditImageDataStatus()
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        if GlobalFunction.isNetworkReachable(){
            if DataInfo().isProductDetailsExists(sellerid: sellerDetail!.id){
                DataInfo().deleteProductDetailsData(sellerid: sellerDetail!.id)
            }
            offlineDataStore()
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callGetProductListService(params: params)
            }
        }else{
            localDataLoad()
            self.downloadCheck()
        }
    }
    
    //MARK:- Offline product list store
    func offlineDataStore(){
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: tempPageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_sellers_products, params: params) { (responseDict, status) in
            if status == 200{
                let productsDetails = ProductModel(fromDictionary: responseDict as! [String : Any])
                if productsDetails.data.data != []{
                    for i in 0..<productsDetails.data.data.count{
                        let JsonData = try?JSONSerialization.data(withJSONObject: productsDetails.data.data[i].toDictionary(), options: [])
                        let jsonString = String(data: JsonData!, encoding: .utf8)!
                        DataInfo().createProductDetailData(id: i, sellerId: self.sellerDetail!.id, pageno: self.tempPageCount, product: jsonString)
                    }
                    self.tempPageCount = self.tempPageCount + 1
                    self.offlineDataStore()
                }else{
                    self.tempPageCount = 1
                }
            }
        }
    }
    
    //MARK:-product data reload
    @objc func productDataReload(notification:Notification){
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                // some process
                if viewController.isKind(of: ProductDetailVC.self) {
                    let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
                    //GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callGetProductListService(params: params)
                        if DataInfo().isProductDetailsExists(sellerid: self.sellerDetail!.id){
                            DataInfo().deleteProductDetailsData(sellerid: self.sellerDetail!.id)
                        }
                        self.offlineDataStore()
                    }
                }
            }
        }
    }
    //MARK:- edit product data save
    @objc func editProductDataSave(notification:Notification){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let dict = notification.userInfo as! [String : Any]
            self.offlineProductData(id: dict["id"] as! Int)
        }
    }
}

//MARK: Button Action Events
extension ProductDetailVC {
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if arrayArchiveIds.count == 0 || arrayArchiveIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.archiveEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmArchiveProduct, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.product_quotation_ids] = self.arrayArchiveIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callSaveService(params: paramDict)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
//        if arrayDeleteIds.count == 0 || arrayDeleteIds.isEmpty {
//            alertbox(title: Messages.error, message: Messages.deleteEmptyAlert)
//        }else {
//            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmDeleteProdut, action1: "Yes", action2: "No") { (status) in
//                if status == 0 {
//                    var paramDict: [String : Any] = [:]
//                    paramDict[Constant.ParameterNames.key] = serviceKey
//                    paramDict[Constant.ParameterNames.product_quotation_ids] = self.arrayDeleteIds
//                    GlobalFunction.showLoadingIndicator()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        self.callDeleteService(params: paramDict)
//                    }
//
//                }
//            }
//        }
        if arrayArchiveIds.count == 0 || arrayArchiveIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.deleteEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmDeleteProdut, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.product_quotation_ids] = self.arrayArchiveIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callDeleteService(params: paramDict)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
//        if arraySubmitIds.count == 0 || arraySubmitIds.isEmpty {
//            alertbox(title: Messages.error, message: Messages.submitEmptyAlert)
//        }else {
//            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmSubmitProduct, action1: "Yes", action2: "No") { (status) in
//                if status == 0 {
//                    var paramDict: [String : Any] = [:]
//                    paramDict[Constant.ParameterNames.key] = serviceKey
//                    paramDict[Constant.ParameterNames.product_quotation_ids] = self.arraySubmitIds
//                    GlobalFunction.showLoadingIndicator()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        self.callSubmitMultipalProduct(params: paramDict)
//                    }
//
//                }
//            }
//        }
        if arrayArchiveIds.count == 0 || arrayArchiveIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.submitEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmSubmitProduct, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.product_quotation_ids] = self.arrayArchiveIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callSubmitMultipalProduct(params: paramDict)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func btnRadioButtonActions(_ sender: UIButton) {
        switch  sender {
        case btnRadioArchive:
            btnRadioDelete.isSelected = false
            btnRadioSubmit.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
//                tblProductDetail.reloadData()
                self.productArray = self.productArray.filter {
                    $0.isSelected = false
                    return true
                }
                self.productDetailCollectionView.reloadData()
            }else {
                sender.isSelected = true
                arraySubmitIds = []
                arrayDeleteIds = []
                for product in productArray{
                    arrayArchiveIds.append(product.id)
                    product.isSelected = true
                }
//                tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }
            break
        case btnRadioDelete:
            btnRadioSubmit.isSelected = false
            btnRadioArchive.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
//                tblProductDetail.reloadData()
                self.productArray = self.productArray.filter {
                    $0.isSelected = false
                    return true
                }
                self.productDetailCollectionView.reloadData()
            }else {
                sender.isSelected = true
                arraySubmitIds = []
                arrayArchiveIds = []
                for product in productArray{
                    arrayDeleteIds.append(product.id)
                    product.isSelected = true
                }
//                tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }
            break
        case btnRadioSubmit:
            btnRadioDelete.isSelected = false
            btnRadioArchive.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
//                tblProductDetail.reloadData()
                self.productArray = self.productArray.filter {
                    $0.isSelected = false
                    return true
                }
                self.productDetailCollectionView.reloadData()
            }else{
                sender.isSelected = true
                arrayDeleteIds = []
                arrayArchiveIds = []
                for product in productArray{
                    arraySubmitIds.append(product.id)
                    product.isSelected = true
                }
//                tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }
            break
        default:
            break
        }
    }
    
    @IBAction func btnProfileAction(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender as UIView, with: ["My Profile","Logout"], menuImageArray: imgArray, done: { (selectedIndex) -> () in
            if selectedIndex == 0{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.profileVC) as! ProfileVC
                vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 80 )
                self.presentPopUp(vc)
            }else{
                self.multiOptionAlertBox(title: Messages.tlv, message: Messages.logoutMsg, action1: "YES", action2: "NO") { (Status) in
                    if Status == 0{
                        UserDefaults.standard.removeObject(forKey: Constant.UserDefaultKeys.currentUserModel)
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.loginVC) as! LoginVC
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }else{
                        
                    }
                }
            }
        }) {
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddProductAction(_ sender: UIButton) {
        let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
        addProductVC.isEditView = false
        addProductVC.sellerId = sellerDetail?.id
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        pageCount += 1
        if GlobalFunction.isNetworkReachable(){
            let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.callGetProductListService(params: params)
            })
        }else{
            let productData = DataInfo().retriveProductDetailData(seller_id: sellerDetail!.id)
            let tempData = productArray
            productArray = []
            for i in productData{
                if i.pageno == pageCount{
                    let dict = GlobalFunction.convertToDictionary(text: i.product_detail!) ?? [:]
                    productArray.append(ProductData(fromDictionary: dict))
                }
            }
            if productArray == []{
                pageCount -= 1
                productArray = tempData
                alertbox(title: Messages.tlv, message: Messages.noDataAvialable)
            }else{
                btnPrevious.isHidden = false
//                self.tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func btnPreviousAction(_ sender: UIButton) {
        pageCount -= 1
        if GlobalFunction.isNetworkReachable(){
            let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.callGetProductListService(params: params)
            })
        }else{
            let productData = DataInfo().retriveProductDetailData(seller_id: sellerDetail!.id)
            let tempData = productArray
            productArray = []
            for i in productData{
                if i.pageno == pageCount{
                    let dict = GlobalFunction.convertToDictionary(text: i.product_detail!) ?? [:]
                    productArray.append(ProductData(fromDictionary: dict))
                }
            }
            if productArray == []{
                pageCount += 1
                productArray = tempData
                alertbox(title: Messages.tlv, message: Messages.noDataAvialable)
            }else{
                if pageCount == 1{
                    btnPrevious.isHidden = true
                }
//                self.tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: TextField Methods
extension ProductDetailVC: UITextFieldDelegate{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtSearch{
            let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: txtSearch.text!, userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.callGetProductListService(params: params)
            })
        }
    }
}

//MARK: TableView Methods
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.productDetailCell) as! ProductDetailCell
        let data = productArray[indexPath.row]
        if data.isDownloaded{
            //detailCell.btnDownload.isHidden = true
            detailCell.btnDownload.isSelected = true
        }else{
            //detailCell.btnDownload.isHidden = false
            detailCell.btnDownload.isSelected = false
        }
        if data.image != nil {
            let imageResponse = data.image!
            let imageItem = imageResponse.components(separatedBy: ",")
            let imgUrl = image_base_url+imageItem[0]
            detailCell.imgProductImage!.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }else {
            detailCell.imgProductImage.image = UIImage()
        }
        detailCell.lblSKU.text = data.sku
        detailCell.lblProductName.text = data.name
        detailCell.lblProductHeight.text = data.height
        detailCell.lblProductWidth.text = data.width
        detailCell.lblProductDepth.text = data.depth
        detailCell.lblDate.text = GlobalFunction.formattedDateFromString(dateString: data.forProductionCreatedAt.date!, withFormat: "MM-dd-yyyy")
        
        if arrayDeleteIds.contains(data.id){
            checkboxAction(cell: detailCell, toSelect: detailCell.btnRadioDelete)
        }else if arraySubmitIds.contains(data.id){
            checkboxAction(cell: detailCell, toSelect: detailCell.btnRadioSubmit)
        }else if arrayArchiveIds.contains(data.id){
            checkboxAction(cell: detailCell, toSelect: detailCell.btnRadioArchive)
        } else {
            checkboxAction(cell: detailCell, toSelect: UIButton())
        }
        
        detailCell.archiveClosure = {
            data.isArchive = data.isArchive ? false : true
            if data.isArchive {
                if !self.arrayArchiveIds.contains(data.id){
                    self.arrayArchiveIds.append(data.id)
                }
            }else {
                if self.arrayArchiveIds.contains(data.id){
                    self.arrayArchiveIds = self.arrayArchiveIds.filter{ $0 != data.id }
                }
            }
            data.isDelete = false
            data.isSubmit = false
//            self.tblProductDetail.reloadData()
            self.productDetailCollectionView.reloadData()
        }
        detailCell.deleteClosure = {
            data.isDelete = data.isDelete ? false : true
            if data.isDelete {
                if !self.arrayDeleteIds.contains(data.id){
                    self.arrayDeleteIds.append(data.id)
                }
            }else {
                if self.arrayDeleteIds.contains(data.id){
                    self.arrayDeleteIds = self.arrayDeleteIds.filter{ $0 != data.id }
                }
            }
            data.isArchive = false
            data.isSubmit = false
//            self.tblProductDetail.reloadData()
            self.productDetailCollectionView.reloadData()
        }
        detailCell.submitClosure = {
            data.isSubmit = data.isSubmit ? false : true
            if data.isSubmit {
                if !self.arraySubmitIds.contains(data.id){
                    self.arraySubmitIds.append(data.id)
                }
            }else {
                if self.arraySubmitIds.contains(data.id){
                    self.arraySubmitIds = self.arraySubmitIds.filter{ $0 != data.id }
                }
            }
            data.isArchive = false
            data.isDelete = false
//            self.tblProductDetail.reloadData()
            self.productDetailCollectionView.reloadData()
        }
        detailCell.submitForPriceClosure = {
            var dictParam: [String : Any] = [:]
            dictParam[Constant.ParameterNames.key] = serviceKey
            dictParam[Constant.ParameterNames.id] = data.id!
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callSubmitForPricing(params: dictParam)
            }
        }
        
        detailCell.downloadDataClosure = {
            if self.productArray[indexPath.row].isDownloaded == false{
                if GlobalFunction.isNetworkReachable(){
                    self.offlineProductData(id: self.productArray[indexPath.row].id)
                    detailCell.btnDownload.isSelected = true
                }else{
                    UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
                }
            }else{
//                self.deleteProductData(data: self.productArray[indexPath.row], cell: detailCell)
            }
        }
        detailCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return detailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if GlobalFunction.isNetworkReachable(){
            let productDict = productArray[indexPath.row]
            let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
            addProductVC.isEditView = true
            addProductVC.sellerId = sellerDetail?.id
            addProductVC.productId = productDict.id!
            self.navigationController?.pushViewController(addProductVC, animated: true)
        }else{
            if self.productArray[indexPath.row].isDownloaded == true{
                let productDict = productArray[indexPath.row]
                let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
                addProductVC.isEditView = true
                addProductVC.sellerId = sellerDetail?.id
                addProductVC.productId = productDict.id!
                self.navigationController?.pushViewController(addProductVC, animated: true)
            }else{
                UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
            }
        }
    }
    
    //MARK:- Download edit product
    func offlineProductData(id: Int){
        var dictParam: [String : Any] = [:]
        dictParam[ Constant.ParameterNames.key ] = serviceKey
        dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
        dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
        dictParam[ Constant.ParameterNames.id] = id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            GlobalFunction.showLoadingIndicator()
            self.getDataToEditSellerProduct(params: dictParam)
        }
    }
    
    //MARK:- delete edit product data
    func deleteProductData(data: ProductData, cell: ProductListCell){
        self.multiOptionAlertBox(title: Messages.tlv, message: Messages.confirmDeleteData, action1: "Yes",action2: "No") { (actionStatus) in
            if actionStatus == 0{
                data.isDownloaded = false
                DataInfo().deleteProductDataDetail(productId: data.id)
                DataInfo().deleteEditImageDataId(id: data.id)
                cell.btnDownload.isSelected = false
            }
        }
    }
}

//MARK: CollectionView Methods
extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.productListCell, for: indexPath as IndexPath) as! ProductListCell
        let data = productArray[indexPath.row]
        
        if data.isSelected == true {
            detailCell.btnTick.isSelected = true
        } else {
            detailCell.btnTick.isSelected = false
        }
        
        if data.isDownloaded{
            //detailCell.btnDownload.isHidden = true
            detailCell.btnDownload.isSelected = true
        }else{
            //detailCell.btnDownload.isHidden = false
            detailCell.btnDownload.isSelected = false
        }
        if data.image != nil {
            let imageResponse = data.image!
            let imageItem = imageResponse.components(separatedBy: ",")
            let imgUrl = image_base_url+imageItem[0]
            detailCell.imgProductImage!.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }else {
            detailCell.imgProductImage.image = UIImage()
        }
        detailCell.lblProductName.text = data.name
        
        detailCell.downComp = {
            if self.productArray[indexPath.row].isDownloaded == false{
                if GlobalFunction.isNetworkReachable(){
                    self.offlineProductData(id: self.productArray[indexPath.row].id)
                    detailCell.btnDownload.isSelected = true
                }else{
                    UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
                }
            }else{
                self.deleteProductData(data: self.productArray[indexPath.row], cell: detailCell)
            }
        }
        
        detailCell.tickComp = {
            if self.arrayArchiveIds.contains(data.id) {
                let key = self.arrayArchiveIds.firstIndex(of: data.id)
                self.arrayArchiveIds.remove(at: key ?? 0)
                data.isSelected = false
            } else {
                self.arrayArchiveIds.append(data.id)
                data.isSelected = true
            }
            self.productDetailCollectionView.reloadItems(at: [indexPath])
        }
        
        return detailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.productDetailCollectionView.bounds.width - 10) / 2, height: CGFloat(120.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInnerVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.productInnerVC) as! ProductInnerVC
        productInnerVC.productData = productArray[indexPath.row]
        productInnerVC.sellerDetail = sellerDetail
        self.navigationController?.pushViewController(productInnerVC, animated: true)
    }
}

//MARK: Web Service Call
extension ProductDetailVC{
    func callGetProductListService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_sellers_products, params: params) { (responseDict, status) in
            let productsDetails = ProductModel(fromDictionary: responseDict as! [String : Any])
            if status == 0 {
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: appName, message: responseDict["message"] as! String)
            }else {
                GlobalFunction.hideLoadingIndicator()
                if productsDetails.data.data.isEmpty {
                    self.alertbox(title: Messages.error, message: Messages.noDataAvialable)
                    if self.pageCount > 1{
                        self.pageCount -= 1
                    }
                }else {
                    self.productArray = productsDetails.data.data
                    self.downloadCheck()
                    if self.pageCount > 1{
                        self.btnPrevious.isHidden = false
                    }else {
                        self.btnPrevious.isHidden = true
                    }
//                    self.tblProductDetail.reloadData()
                    self.productDetailCollectionView.reloadData()
                }
            }
        }
    }
    
    func callSubmitForPricing(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_for_pricing, params: params) { (responseDict, status) in
            
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: appName, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    
    func callSaveService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.archive_product_qoutation, params: params) { (responseDict, status) in
            if status == 200 {
                GlobalFunction.hideLoadingIndicator()
                self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: appName, message: responseDict["message"]! as! String)
            }
        }
    }
    func callDeleteService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.delete_product_qoutation, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    GlobalFunction.hideLoadingIndicator()
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"] as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: appName, message: responseDict["message"] as! String)
                }
            }
        }
    }
    func callSubmitMultipalProduct(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_multiple_product_for_pricing, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    GlobalFunction.hideLoadingIndicator()
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: appName, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    
    //MARK:- edit product data get
    func getDataToEditSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.edit_seller_product_for_production_stage, params: params) { (responseDict, status) in
            if status == 200{
                if DataInfo().isProductDataDetailExists(productId: params[Constant.ParameterNames.id] as! Int){
                    DataInfo().deleteProductDataDetail(productId: params[Constant.ParameterNames.id] as! Int)
                    DataInfo().deleteEditImageDataId(id: params[Constant.ParameterNames.id] as! Int)
                }
                let JsonData = try?JSONSerialization.data(withJSONObject: responseDict as! [String : Any], options: [])
                let productDataOffline = String(data: JsonData!, encoding: .utf8)!
                let productData = AddProductModel(fromDictionary: responseDict as! [String : Any])
                DataInfo().createProductData(productId: params[Constant.ParameterNames.id] as! Int, productData: productDataOffline)
                let image = productData.data.product.productId.productPendingImages ?? []
                GlobalFunction.hideLoadingIndicator()
                for i in 0..<image.count{
                    let data = try? Data(contentsOf: URL(string: image_base_url + image[i].name)!)
                    DataInfo().createEditImageData(productId: params[Constant.ParameterNames.id] as! Int, imageData: data!, status: 1)
                    if i == image.count - 1 {
                        GlobalFunction.hideLoadingIndicator()
                    }
                }
                self.downloadCheck()
//                self.tblProductDetail.reloadData()
                self.productDetailCollectionView.reloadData()
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    //MARK:- Offline Data Load
    func localDataLoad() {
        productArray = []
        let productData = DataInfo().retriveProductDetailData(seller_id:sellerDetail!.id)
        for i in productData{
            if i.pageno == pageCount{
                let dict = GlobalFunction.convertToDictionary(text: i.product_detail!) ?? [:]
                productArray.append(ProductData(fromDictionary: dict))
            }
        }
        if productArray == []{
            self.view.makeToast(Messages.noInternet)
            btnNext.isHidden = true
        }else{
//            self.tblProductDetail.reloadData()
            self.productDetailCollectionView.reloadData()
        }
    }
    
    //MARK:- Download Data check
    func downloadCheck(){
        let productData = DataInfo().retriveProductDataDetails()
        var ids = [Int]()
        for i in productData{
            ids.append(Int(i.product_id))
        }
        self.productIds = ids
        for i in self.productArray{
            for j in self.productIds{
                if i.id == j{
                    i.isDownloaded = true
                }
            }
        }
    }
}

//MARK: refresh method
extension ProductDetailVC {
    @objc func refresh(_ sender: AnyObject) {
        if GlobalFunction.isNetworkReachable(){
            let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callGetProductListService(params: params)
            }
            if DataInfo().isProductDetailsExists(sellerid: sellerDetail!.id){
                DataInfo().deleteProductDetailsData(sellerid: sellerDetail!.id)
            }
            offlineDataStore()
            refreshControl.endRefreshing()
        }else{
            UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
            refreshControl.endRefreshing()
        }
        
    }
    
    func apiParameters(serviceKeyData: String, pageCountData: Int, searchString: String, userId: Int, roleId: Int, sellerId: Int) -> [String: Any]{
        var sellerDetailsParams: [String : Any] = [:]
        sellerDetailsParams[Constant.ParameterNames.key] = serviceKeyData
        sellerDetailsParams[Constant.ParameterNames.page] = pageCountData
        sellerDetailsParams[Constant.ParameterNames.role_id] = roleId
        sellerDetailsParams[Constant.ParameterNames.search] = searchString
        sellerDetailsParams[Constant.ParameterNames.seller_id] = sellerId
        sellerDetailsParams[Constant.ParameterNames.user_id] = userId
        return sellerDetailsParams
    }
    
    //for select all cells radio from checkbox selection
    func checkboxAction(cell: ProductDetailCell, toSelect: UIButton){
        cell.btnRadioArchive.isSelected = toSelect == cell.btnRadioArchive ?  true :  false
        cell.btnRadioDelete.isSelected = toSelect == cell.btnRadioDelete ?  true :  false
        cell.btnRadioSubmit.isSelected = toSelect == cell.btnRadioSubmit ?  true :  false
    }
}
