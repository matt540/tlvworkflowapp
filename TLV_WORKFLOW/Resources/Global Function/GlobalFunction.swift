

import Foundation
import UIKit
import Alamofire
import CoreLocation

class GlobalFunction: NSObject {
  
    static let manager = NetworkReachabilityManager(host: "https://www.google.com")
    static var hub = ProgressHUD()

    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    static func GlobalPrintLogs(strMessage: Any) {
        print(strMessage)
    }
    
    // MARK: - check network indicator
    static func isNetworkReachable() -> Bool {
        if (manager?.isReachable)!{
            return true
        }else{

            return false
        }
    }
    


    static func showLoadingIndicator(title: String = "",detail: String = "",textOnly : Bool = false) {
        
        hub = ProgressHUD.show(addedToView: (UIApplication.shared.windows.first)!, animated: true)

        if textOnly {
            hub.mode = .text
            hub.offset = CGPoint(x: 0, y: ProgressHUD.maxOffset)
        }
        
        if title != "" {
            hub.label?.text = title
        }
        
        if detail != "" {
            hub.detailsLabel?.text = detail
        }

    }
    
    static func hideLoadingIndicator() {
        hub.hide(animated: true)
    }

    
    static func printResponce(From response: Any) {
        guard case GlobalFunction.isSimulator  = true else { return }
        print("\n\n=====================================\n\n\(response)")
    }
    
    static func getCountryList() -> NSMutableArray {
        var countryList = NSMutableArray()
        if let path = Bundle.main.path(forResource: "country-calling-codes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["Data"] as? [Any] {
                    
                    countryList = NSMutableArray()
                    let list = NSMutableArray.init(array: person)
                    for i in 0..<list.count {
                        var dict: [String: Any] = list.object(at: i) as! [String: Any]
                        dict["flag"] = self.flag(country: dict["code"] as! String)
                        countryList.add(dict)
                    }
                }
            } catch {
                // handle error
            }
        }
        return countryList
    }
    
    static func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    
    static func getStrDate(mDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: mDate)
    }
    
    static func resizeImage(image: UIImage) -> Data {
          var actualHeight: Float = Float(image.size.height)
          var actualWidth: Float = Float(image.size.width)
          let maxHeight: Float = 300.0
          let maxWidth: Float = 400.0
          var imgRatio: Float = actualWidth / actualHeight
          let maxRatio: Float = maxWidth / maxHeight
          let compressionQuality: Float = 0.6
          //50 percent compression
          
          if actualHeight > maxHeight || actualWidth > maxWidth {
              if imgRatio < maxRatio {
                  //adjust width according to maxHeight
                  imgRatio = maxHeight / actualHeight
                  actualWidth = imgRatio * actualWidth
                  actualHeight = maxHeight
              }
              else if imgRatio > maxRatio {
                  //adjust height according to maxWidth
                  imgRatio = maxWidth / actualWidth
                  actualHeight = imgRatio * actualHeight
                  actualWidth = maxWidth
              }
              else {
                  actualHeight = maxHeight
                  actualWidth = maxWidth
              }
          }
          
          let rect = CGRect(x: 0.0, y: 0.0, width: Double(actualWidth), height: Double(actualHeight))
          UIGraphicsBeginImageContext(rect.size)
          image.draw(in: rect)
          let img = UIGraphicsGetImageFromCurrentImageContext()
          let image = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
          UIGraphicsEndImageContext()
          //        return UIImage(data: imageData!)!
          return image!
      }
    
    static func checkLocationPermission(completion: @escaping (_ status: Bool) -> Void) {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:

                let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in

                        })
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))

                completion(false)
                break
                
            case .authorizedAlways, .authorizedWhenInUse:
                
                completion(true)
            @unknown default:
                break
            }
        }
    }
    
    static func isValidEmail(email:String) -> Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(password:String) -> Bool{
         password.count < 6 ? true : false
    }
    static func findLocationDistance(startLat: Double,startLong: Double,endLat: Double,endLong: Double) -> Double {
        let coordinate₀ = CLLocation(latitude: startLat, longitude: startLong)
        let coordinate₁ = CLLocation(latitude: endLat, longitude: endLong)
        let distance = coordinate₀.distance(from: coordinate₁) / 1000
        return distance
    }
    static func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

extension UIDevice {
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UITextField {
    func isEmpty() -> Bool{
        if text == "" || text == nil {
            return true
        }
        return false
    }
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
extension NSMutableAttributedString{
    // If no text is send, then the style will be applied to full text
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
    // If no text is send, then the style will be applied to full text
    func setHighlightColorForText(_ textToFind:String?,with color:UIColor){
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: range!)
        }
    }
    
    // If no text is send, then the style will be applied to full text
    func setUnderlineWith(_ textToFind:String?, with color: UIColor){
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.underlineStyle, value:NSUnderlineStyle.thick.rawValue, range: range!)
            addAttribute(NSAttributedString.Key.underlineColor, value:color , range: range!)
        }
    }
}

