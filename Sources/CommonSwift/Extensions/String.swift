//
//  String.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 08/09/2023.
//

import Foundation

public extension String {
    
    static var empty = ""
    
    var spaceRemoved: String {
        self.components(separatedBy: .whitespaces).joined()
    }
    
    var dotRemoved: String {
        self.replacingOccurrences(of: ".", with: "")
    }
    
    var url: URL? {
        URL(string: self)
    }
    
    var toInt: Int? {
        Int(self)
    }
    
    var toDouble: Double? {
        Double(self)
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    var firstLetterCapitalized: String {
        self.prefix(1).uppercased() + self.dropFirst()
    }
    
    /// Convert boolean-able string to `Bool` type
    ///
    ///The following will return true
    ///```
    ///"True".toBool()
    ///"true".toBool()
    ///"yes".toBool()
    ///"1".toBool()
    ///```
    ///
    ///The following will return false
    ///```
    ///"False".toBool()
    ///"false".toBool()
    ///"no".toBool()
    ///"0".toBool()
    ///```
    ///
    ///The rest will return nil since they can't convert into proper boolean type
    ///```
    ///"Lol".toBool()
    ///```
    ///
    /// - Returns: `Optional<Bool>`
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /// Convert boolean-able string to `Int` type, return `1` if `true`, `0` if `false`, `nil` if failed to convert
    ///
    ///The following will return 1
    ///```
    ///"True".toBool()
    ///"true".toBool()
    ///"yes".toBool()
    ///"1".toBool()
    ///```
    ///
    ///The following will return 0
    ///```
    ///"False".toBool()
    ///"false".toBool()
    ///"no".toBool()
    ///"0".toBool()
    ///```
    ///
    ///The rest will return nil since they can't convert into proper int value
    ///```
    ///"Lol".toBool()
    ///```
    ///
    /// - Returns: `Optional<Int>`
    func toIntFlag() -> Int? {
        switch self {
        case "True", "true", "yes", "1":
            return 1
        case "False", "false", "no", "0":
            return 0
        default:
            return nil
        }
    }
    
    /// Extract substring from the main string
    ///
    ///```
    ///"Hello, World!".substring(from: 2, to: 7) // "llo, W"
    ///```
    ///
    /// - Parameters:
    ///   - from: From index (inclusive)
    ///   - to: To index (inclusive)
    /// - Returns: String
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    /// Convert the given local time string to UTC time string
    ///
    ///```
    /// "14:00".convertToUTCTimestamp() // Will return "07:30"
    /// ```
    ///
    /// - Returns: `Optional<String>`
    func convertToUTCTimestamp() -> String? {
        let strArr: [String] = self.components(separatedBy: ":")
        guard strArr.count > 1 else {
            return nil
        }
        
        let int0 = Int(strArr[0])
        let int1 = Int(strArr[1])
        let calendar = Calendar.current
        let today = Date()
        
        let com = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: today)
        
        var newcom = DateComponents()
        newcom.year = com.year
        newcom.month = com.month
        newcom.day = com.day
        newcom.hour = int0
        newcom.minute = int1
        let newcomdate = calendar.date(from: newcom)!
        
        let finalf = DateFormatter()
        finalf.dateFormat = "HH:mm"
        finalf.timeZone = TimeZone(abbreviation: "UTC")
        let finalfString = finalf.string(from: newcomdate)
        return finalfString
    }
    
    /// Validate e-mail format. Can opt-in custom domains to check the validity of the given mail.
    ///
    ///Custom domains are empty by default. There are cases you want to validate your mail not only by the mail format, but also by certain domain names.
    ///
    /// ```
    /// "hello@lol.io".isValidEmail() // true
    /// "hi".isValidEmail() // false
    ///
    ///"hello@gmail.com".isValidEmail(forCustomDomains: ["gmail", "yahoo"]) // true
    ///"hello@lol.io".isValidEmail(forCustomDomains: ["gmail", "yahoo"]) // false
    ///
    /// ```
    ///
    /// - Parameter domains: An array of domain you want to include
    /// - Returns: Bool
    func isValidEmail(forCustomDomains domains: [String] = []) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailTest.evaluate(with: self) {
            if domains.isEmpty {
                return true
            } else {
                return domains.reduce(false) {
                    $0 || self.contains("@\($1)")
                }
            }
        }
        
        return false
    }
}

#if canImport(UIKit)
import UIKit

public extension String {
    
    var toCGFloat: CGFloat? {
        if let number = NumberFormatter().number(from: self) {
            return CGFloat(exactly: number)
        }
        
        return nil
    }

    /// Strike through the give string
    /// - Returns: `NSAttributedString`
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        guard self.isNotEmpty else { return 0 }
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.height
    }

}

#endif
