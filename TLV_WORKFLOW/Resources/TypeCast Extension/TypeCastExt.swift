

import UIKit

extension Optional {
    func string(with decimal: String = "0") -> String {
        if let val = self as? String {
            return val
        } else if let val = self as? Int {
            return val.description
        } else if let val = self as? CGFloat {
            if val > 0 {
                return String(format: "%0.\(decimal)f", val)
            } else {
                return ""
            }
        } else if let val = self as? Bool {
            return (val == true) ? "1" : "0"
        } else if let val = self as? Float {
            if val > 0 {
                return String(format: "%0.\(decimal)f", val)
            } else {
                return ""
            }
        } else {
            guard let val = self as? Double else {
                return ""
            }
            if val > 0.0 {
                return String(format: "%0.\(decimal)f", val)
            } else {
                return ""
            }
        }
    }
    
    func float(with decimal: String = "0") -> CGFloat {
        let valueMain: String = self.string(with: decimal)
        guard let n = NumberFormatter().number(from: valueMain) else { return 0.0 }
        return CGFloat(truncating: n)
    }
    
    func double(with decimal: String = "0") -> Double {
        let valueMain: String = self.string(with: decimal)
        guard let n = NumberFormatter().number(from: valueMain) else { return 0.0 }
        return Double(CGFloat(truncating: n))
    }
    
    func int() -> Int {
        let valueMain: String = self.string()
        return (valueMain as NSString).integerValue
    }
    
    func bool() -> Bool {
        if let val = self as? String {
            return val == "0" ? false : true
        } else if let val = self as? Int {
            return val == 0 ? false : true
        } else {
            return self as? Bool ?? false
        }
    }
}
