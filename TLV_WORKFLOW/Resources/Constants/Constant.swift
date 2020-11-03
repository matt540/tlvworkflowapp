

import UIKit

let appName = "App Name"

let baseUrl = "http://tlv-workflowapp.com/api/mobile/"

let profileImageUrl = "http://tlv-workflowapp.com/Uploads/profile/"

let image_base_url = "http://tlv-workflowapp.com/Uploads/product/thumb/"
let serviceKey = "$2y$10$aROSSAxEG7RgVYPL.f7VWOxWKIcly0ekxrNwc2h1Swktd1g0hl2/C"

let deviceID = UIDevice.current.identifierForVendor?.uuidString
var APP_DELEGATE: AppDelegate!
var currentLoginUser : LoginModel!


class Constant: NSObject {
    
     static let AppDel = UIApplication.shared.delegate as! AppDelegate
    
    struct Screen {
        static let Width         = UIScreen.main.bounds.size.width
        static let Height        = UIScreen.main.bounds.size.height
        static let Max_Length    = max(Width, Height)
        static let Min_Length    = min(Width, Height)
        
        static let iPhone                                      = UIDevice.current.userInterfaceIdiom == .phone
        static let iPad                                        = UIDevice.current.userInterfaceIdiom == .pad
        static let isNotchAvailable                            = Max_Length > 736 && iPhone
        static let iPhone_4                                    = Max_Length == 480
        static let iPhone_5                                    = Max_Length == 568
        static let iPhone_6_7_8                                = Max_Length == 667
        static let iPhone_6P_7P_8P                             = Max_Length == 736
        static let iPad_Mini_Air                               = Max_Length == 1024
        static let iPad_10_Pro                                 = Max_Length == 1112
        static let iPad_11_12_Pro                              = Max_Length == 1366
        
    }
    
    struct storyboard {
        static let onboarding = "OnBoarding"

    }
    struct UserDefaultKeys {
        static let currentUserModel = "UserData"
    
    }
    
    struct Api {
        static let logout = "logout"
        static let login = "login"
        static let getSellerList = "get_sellers_for_production"
        static let editUserProfile = "user/edit_profile"
        static let imageUpload = "upload_image"
        static let get_sellers_products = "get_sellers_produts_for_production_stage"
        static let submit_for_pricing = "product_quotation/submit_to_pricing_stage"
        static let archive_product_qoutation = "product_quotation/archive_product_quotation"
        static let delete_product_qoutation = "product_quotation/delete_product_quotation"
        static let submit_multiple_product_for_pricing = "product_quotation/submit_multiple_products_to_pricing_stage"
        static let add_seller_product_for_production_stage = "add_seller_product_for_production_stage"
    }
    
    struct segueId {
        static let loginToOtp = "LoginVCToOTPVC"
    }
    
    struct validationMessage {
        
        static let noInternetMSG = "Please Check Internet Connection"
        static let emptyEmailMSG = "Please Enter Email"
        static let emptyPasswordMSG = "Please Enter Password"
        static let invalidEmailMSG = "Please Enter Valid Email"
        static let emptyFirstNameMSG = "Please Enter FirstName"
        static let emptyLastNameMSG = "Please Enter LastName"
        static let emptyPhoneNoMSG = "Please Enter PhoneNumber"
        static let passwordValidation = "Password Must Be Greater Then Six Character"
    }
    
    struct Color {
        static let themeColor = #colorLiteral(red: 0.8274509804, green: 0.2549019608, blue: 0.1019607843, alpha: 1)
        static let subscriptionGradient = [#colorLiteral(red: 0.5294117647, green: 0.8705882353, blue: 1, alpha: 1),#colorLiteral(red: 0.07058823529, green: 0.7294117647, blue: 0.9764705882, alpha: 1)]
        static let btnDeselectColor = #colorLiteral(red: 0.9137254902, green: 0.937254902, blue: 0.9725490196, alpha: 1)
    }
    
    struct VCIdentifier {
        static let loginVC = "LoginVC"
        static let productListVC = "ProductListVC"
        static let productDetailVC = "ProductDetailVC"
        static let profileVC = "ProfileVC"
        static let addNewSellerVC = "AddNewSellerVC"
    }
    
    struct CellIdentifier {
        static let productDetailCell = "ProductDetailCell"
    }
    
    struct ParameterNames {
        static let id = "id"
        static let email = "email"
        static let password = "password"
        static let key = "key"
        static let page = "page"
        static let role_id = "role_id"
        static let search = "search"
        static let seller_id = "seller_id"
        static let user_id = "user_id"
        static let firstName = "firstname"
        static let lastName = "lastname"
        static let profileImage = "profile_image"
        static let phoneNo = "phone"
        static let folder = "folder"
        static let production_quotation_ids = "production_quotation_ids"
    }
    
    struct FolderNames {
        static let profile = "profile"
    }
    
}

extension Date {
    var startOfWeek: String {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return ""}
        //return gregorian.date(byAdding: .day, value: 1, to: sunday)
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from:gregorian.date(byAdding: .day, value:0, to: sunday) ?? Date())
    }
    
    var endOfWeek: String? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return "" }
        //return gregorian.date(byAdding: .day, value: 7, to: sunday)
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from:gregorian.date(byAdding: .day, value:6, to: sunday) ?? Date())
    }
    
    func startOfMonth() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!)
        // return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to:  Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!) ?? Date())
    }
}

extension String {
    
    func toDate(withFormat format: String = "EEEE. MMM. d")-> String {
        var suffix = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        // let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        let finalDate = dateFormatter.string(from: date)
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: dateFormatter.date(from: finalDate) ?? Date())
        let day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            suffix = "st"
        // day.append("st")
        case "2" , "22":
            suffix = "nd"
        // day.append("nd")
        case "3" ,"23":
            suffix = "rd"
        // day.append("rd")
        default:
            suffix = "th"
            // day.append("th")
        }
        return  finalDate + suffix
    }
    
    func getStartTimeFormate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return ""
        
    }
    
}
