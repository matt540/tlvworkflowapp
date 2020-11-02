

import Foundation
import UIKit

extension UIView {
    
    func addAndFitSubview(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let views = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: views))
    }
    
    func roundedUsingWidth() {
        self.rounded(cornerRadius: self.frame.size.width/2)
    }
    
    func roundedUsingHeight() {
        self.layoutIfNeeded()
        self.rounded(cornerRadius: self.frame.size.height/2)
    }
    
    func rounded(cornerRadius: CGFloat) {
        self.layoutIfNeeded()
        self.layer.cornerRadius = cornerRadius
        //        self.layer.masksToBounds = true
    }
    
    func applyShadow(
        apply: Bool,
        color: UIColor = UIColor.black,
        offset: CGSize = CGSize(width: 0.0, height: 2.0),
        opacity: Float = 0.2, radius: Float = 1.0,
        shadowRect: CGRect? = nil) {
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = apply ? offset : CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = apply ? opacity : 0.0
        self.layer.shadowRadius = apply ? CGFloat(radius) : 0.0
        self.layer.masksToBounds = false
        if let shadowRect = shadowRect {
            self.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        }
    }
    
    func applyGlow(apply: Bool, color: UIColor) {
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = apply ? 0.4 : 0.0
        self.layer.shadowRadius = apply ? 10.0 : 0.0
        self.layer.masksToBounds = false
    }
    
    var nibName: String {
        return type(of: self).description().components(separatedBy: ".").last! // to remove the module name and get only files name
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    // MARK: IBInspectable
    
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.white.cgColor
            return UIColor(cgColor: color) // not using this property as such
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var roundCorner: Bool {
        get {
            return false
        }
        set {
            if newValue {
                
                self.roundedUsingHeight()
            }
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            if !roundCorner {
                self.layer.cornerRadius = newValue
                self.rounded(cornerRadius: newValue)
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            let color = self.layer.shadowColor ?? UIColor.white.cgColor
            return UIColor(cgColor: color) // not using this property as such
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var addPulseEffect: Bool {
        get {
            return false
        }
        set {
            if newValue {
                let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
                pulseAnimation.duration = 1
                pulseAnimation.fromValue = 0
                pulseAnimation.toValue = 1
                pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                pulseAnimation.autoreverses = true
                pulseAnimation.repeatCount = .greatestFiniteMagnitude
                self.layer.add(pulseAnimation, forKey: "animateOpacity")
            }
        }
    }
    
    @IBInspectable var applyGradiant: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.3
                self.layer.shadowRadius = 5
                self.layer.shadowOffset = CGSize(width: 0, height: -3)
                self.layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var setTopCornerRadious: CGFloat {
        get {
            return 0
        }
        
        set {
            if newValue > 0 {
                self.setNeedsFocusUpdate()
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: newValue, height: newValue))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
                self.layoutIfNeeded()
            }
        }
    }
    
    open func setRoundCorners(corners: UIRectCorner, cornerRadious: CGFloat) {
        self.layoutIfNeeded()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
extension CAGradientLayer {
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custion(point: CGPoint)
        
        var point: CGPoint {
            switch self {
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .custion(let point): return point
            }
        }
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.init()
        self.frame = frame
        self.colors = colors.map { $0.cgColor }
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: Point, endPoint: Point) {
        self.init(frame: frame, colors: colors, startPoint: startPoint.point, endPoint: endPoint.point)
    }
    
    func createGradientImage() -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIView {
    
    func setGradient(colors: [UIColor], startPoint: CAGradientLayer.Point = .topLeft, endPoint: CAGradientLayer.Point = .bottomLeft, applyCornerRadious: CGFloat = 0) {
        let gradientLayer = CAGradientLayer(frame: self.bounds, colors: colors, startPoint: startPoint, endPoint: endPoint)
        
        self.layer.sublayers?.forEach({ (layer) in
            if let layerGrad = layer as? CAGradientLayer {
                layerGrad.removeFromSuperlayer()
            }
        })
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
extension  UIView {
    func createImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            let rect: CGRect = self.frame
            defer { UIGraphicsEndImageContext() }
            UIGraphicsBeginImageContext(rect.size)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            self.layer.render(in: context)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return img!
        }
    }
    
    func plotMapkitImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            let rect: CGRect = self.frame
            defer { UIGraphicsEndImageContext() }
            UIGraphicsBeginImageContext(rect.size)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            self.layer.render(in: context)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            img?.jpegData(compressionQuality: 0.1)
            return img!
        }
    }
    
}

extension UIView {
    
    func rotate(degrees: CGFloat) {
        
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        
        // If you like to use layer you can uncomment the following line
        //layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
}
extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension Int {
    func timeDisplay() -> String {
        
        let minute = String(format: "%02d", (self % 3600) / 60)
        let second = String(format: "%02d", ((self % 3600) % 60))
        return "\(minute):\(second)"
    }
}
class VCThumbTextSlider: UISlider {
    
    var thumbTextLabel: UILabel = UILabel()
    var thumbTextBG: UIImageView = UIImageView()
    
    @IBInspectable var postfixText: String = ""
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = thumbFrame
        frame.origin.y = -30
        frame.size.width = 80
        frame.size.height = 30
        
        if frame.origin.x > ((UIApplication.shared.keyWindow?.frame.size.width)! - 80) {
            frame.origin.x = frame.origin.x - 40
            thumbTextBG.image = #imageLiteral(resourceName: "ping_left")
        } else if frame.origin.x < ((UIApplication.shared.keyWindow?.frame.size.width)! - 40) &&
            frame.origin.x > 20 {
            frame.origin.x = frame.origin.x - 15
            thumbTextBG.image = #imageLiteral(resourceName: "ping_center")
        } else {
            //            if VCLangauageManager.sharedInstance.isLanguageEnglish() {
            frame.origin.x = frame.origin.x + 5
            thumbTextBG.image = #imageLiteral(resourceName: "ping_right")
            //            } else {
            //                frame.origin.x = frame.origin.x - 47
            //                thumbTextBG.image = #imageLiteral(resourceName: "bubbleRight")
            //                if frame.origin.x < 10 {
            //                    frame.origin.x = frame.origin.x + 57
            //                    thumbTextBG.image = #imageLiteral(resourceName: "bubbleLeft")
            //                }
            //            }
        }
        
        frame.size.width = 60
        UIView.animate(withDuration: 0.2) {
            frame.origin.y = frame.origin.y - 4
            self.thumbTextLabel.frame = frame
            frame.origin.y = frame.origin.y + 4
            frame.size.height = frame.size.height + 5
            self.thumbTextBG.frame = frame
            let val = String(format: "%.0f", self.value)
            self.thumbTextLabel.text = "\(val) \(self.postfixText)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(thumbTextBG)
        addSubview(thumbTextLabel)
        let font = UIFont(name: "Poppins-Regular", size: 11)
        thumbTextLabel.textColor = #colorLiteral(red: 0.07058823529, green: 0.7294117647, blue: 0.9764705882, alpha: 1)
        thumbTextLabel.font = font
        thumbTextLabel.cornerRadius = 15
        thumbTextLabel.clipsToBounds = true
        thumbTextLabel.backgroundColor = .clear
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
    }
}
extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
extension String
{
    func encodeUrl() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func decodeUrl() -> String{
        return self.removingPercentEncoding!
    }
}

extension String {
    func images() -> UIImage {
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


extension UIViewController{
    //MARK: Simple Alert

    func alertbox(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func multiOptionAlertBox(title : String, message: String,action1 : String,action2 : String = "",completion: @escaping (_ status: Int) -> Void)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action1, style: .default, handler: { (action) in
            completion(0)
        }))
        if action2 != "" {
            alertController.addAction(UIAlertAction(title: action2, style: .default, handler: { (action) in
                completion(1)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
