//
//  ProductListVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 28/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import MessageUI

class ProductListVC: UIViewController {
    
    
    @IBOutlet weak var sellerTableView: UITableView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    var sellerList:[SellerListData] = []
    var pageCount = 1
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetSellerListService(params: params)
        }
        btnPrevious.isHidden = true
        searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        sellerTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetSellerListService(params: params)
        }
        self.sellerTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //MARK:- Seller Service List
    func callGetSellerListService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.getSellerList, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let sellerData = SellerListModel(fromDictionary: responseDict as! [String : Any])
                self.sellerList =  sellerData.data!.data
                if self.sellerList.count == 0 {
                    self.sellerTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                    if self.pageCount == 1{
                        
                    }else{
                        self.pageCount -= 1
                    }
                    self.multiOptionAlertBox(title: Messages.tlv, message: Messages.noSeller, action1: "YES",action2: "NO") { (status) in
                        if status == 0{
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.addNewSellerVC) as! AddNewSellerVC
                            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
//                            self.popUpEffectType = .flipUp
                            self.presentPopUp(vc)
                        }else{
                            let params = self.apiParameter(serviceKeyData: serviceKey, pageCountData: self.pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
                            GlobalFunction.showLoadingIndicator()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.callGetSellerListService(params: params)
                            }
                        }
                    }
                }
                
                if self.pageCount == 1{
                    self.btnPrevious.isHidden = true
                }else if self.pageCount == 0{
                    self.btnPrevious.isHidden = true
                }else{
                    self.btnPrevious.isHidden = false
                }
                
                self.sellerTableView.reloadData()
            }
        }
    }
    
    //MARK:- Calling Function
    func btnPhoneNo(phoneNo: String){
        if phoneNo == "" {
            alertbox(title: Messages.alert, message: Messages.phoneNoNotFound)
        }else{
            if let url = URL(string: "tel://\(phoneNo)"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK:- Open Google Map
    func openGoogleMap(address: String){
        if address == ""{
            alertbox(title: Messages.alert, message: Messages.addressNotFound)
        }else{
            let urlString = "http://maps.google.com/maps?q=\(address)"
            let escaped = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
            if let url = URL(string: escaped ?? ""),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK:- Set Parameter for API
    func apiParameter(serviceKeyData: String, pageCountData: Int, searchString: String, userId: Int, roleId: Int) -> [String : Any]{
        var params: [String : Any] = [:]
        params[Constant.ParameterNames.key] = serviceKeyData
        params[Constant.ParameterNames.page] = pageCountData
        params[Constant.ParameterNames.search] = searchString
        params[Constant.ParameterNames.user_id] = userId
        params[Constant.ParameterNames.role_id] = roleId
        return params
    }
    
    @IBAction func btnProfileAction(_ sender: Any) {
        FTPopOverMenu.showForSender(sender: sender as! UIView,
                                    with: ["My Profile","Logout"],
                                    menuImageArray: imgArray,
                                    done: { (selectedIndex) -> () in
                                        if selectedIndex == 0{
                                            
                                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.profileVC) as! ProfileVC
                                            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 80 )
//                                            self.popUpEffectType = .flipUp
                                            self.presentPopUp(vc)
                                            
                                        }else{
                                            
                                        }
        }) {
            
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        pageCount += 1
        let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetSellerListService(params: params)
        }
    }
    
    @IBAction func btnPreviousAction(_ sender: Any) {
        pageCount -= 1
        let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetSellerListService(params: params)
        }
    }
}

//MARK:- Seller TableView Methods
extension ProductListVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sellerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerListCell") as! SellerListCell
        cell.lblFirstName.text = sellerList[indexPath.row].firstname
        cell.lblLastName.text = sellerList[indexPath.row].lastname
        cell.lblEmail.text = sellerList[indexPath.row].email
        cell.lblPhoneNo.text = sellerList[indexPath.row].phone
        cell.lblAddress.text  = sellerList[indexPath.row].address
        cell.lblProductCount.text = sellerList[indexPath.row].pendingCount
        cell.emailClosure = {
            self.sendEmail(mailId: self.sellerList[indexPath.row].email)
        }
        
        cell.phonoNoClosure = {
            self.btnPhoneNo(phoneNo: self.sellerList[indexPath.row].phone)
        }
        
        cell.addressClosure = {
            self.openGoogleMap(address: self.sellerList[indexPath.row].address)
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let sellerDetail = sellerList[indexPath.row]
                let productDetailVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.productDetailVC) as! ProductDetailVC
                productDetailVC.sellerDetail = sellerDetail
                self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

//MARK:- SearchBar Calling Methods
extension ProductListVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        GlobalFunction.hideLoadingIndicator()
        if searchText.isEmpty{
            let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callGetSellerListService(params: params)
            }
            sellerTableView.reloadData()
        }else{
            let params = apiParameter(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: searchText, userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callGetSellerListService(params: params)
            }
            //sellerTableView.reloadData()
        }
    }
}
//MARK:- Mail Open
extension ProductListVC: MFMailComposeViewControllerDelegate{
    func sendEmail(mailId: String) {
        if mailId == ""{
            alertbox(title: Messages.alert, message: Messages.emailNotFound)
        }else{
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([mailId])
                present(mail, animated: true)
            } else {
                // show failure alert
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

