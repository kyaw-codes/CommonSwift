//
//  Int.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension Int {
    
    var kilobytes: Double {
        return Double(self) / 1024
    }
    
    var megabytes: Double {
        return kilobytes / 1024
    }
    
    var gigabytes: Double {
        return megabytes / 1024
    }
    
    var milisecondToSecond: Float {
        Float(self) / 1000
    }
    
    func getReadableUnit() -> String {
        switch self {
        case 0..<1024:
            return "\(self) bytes"
        case 1024..<(1024 * 1024):
            return "\(String(format: "%.2f", kilobytes)) kb"
        case 1024..<(1024 * 1024 * 1024):
            return "\(String(format: "%.2f", megabytes)) mb"
        case (1024 * 1024 * 1024)...Int(Int64.max):
            return "\(String(format: "%.2f", gigabytes)) gb"
        default:
            return "\(self) bytes"
        }
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var string: String {
        return String(self)
    }
    
    func toString(digit: Int = 2) -> String? {
        return String(format: "%0\(digit)d", self)
    }
    
    func secondToFormattedMinutes() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func secondToFormattedHour() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
    func secondToHour() -> (h: String?, m: String, s: String) {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            let value = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
                .split(separator: ":").compactMap { "\($0)" }
            return (value[0], value[1], value[2])
        } else {
            let value = String(format: "%02i:%02i", minutes, seconds).split(separator: ":").compactMap { "\($0)" }
            return (nil, value[0], value[1])
        }
    }
    
    /// `1_000_000.commaFormattedString()` will return `"1,000,000"`
    func commaFormattedString(locale: String?, groupingSeparator: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = groupingSeparator
        
        if let locale = locale {
            numberFormatter.locale = Locale(identifier: locale)
        }
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    
    /// Convert `Int` to coma formatted string with currency symbol
    ///
    ///```
    ///// Return 10,000 $
    ///10000.toCurrency()
    ///
    ///// Return $ 10,000
    ///10000.toCurrency(with: "$", symbolPositionTrailing: false)
    ///```
    ///
    /// - Parameters:
    ///   - symbol: Currency symbol (Eg- $, €)
    ///   - symbolPositionTrailing: If `true`, the symbol will be attached to the trailing side of the string, otherwise, the leading side
    ///   - default: Default value if anything went wrong
    /// - Returns: Currency string
    func toCurrency(with symbol: String = "$", symbolPositionTrailing: Bool = true, default: String = "") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if symbolPositionTrailing {
            formatter.positiveFormat = "#,##0 ¤"
            formatter.negativeFormat = "-#,##0 ¤"
        } else {
            formatter.positiveFormat = "¤ #,##0"
            formatter.negativeFormat = "¤ -#,##0"
            
        }
        formatter.currencySymbol = symbol
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)).orElse(`default`)
    }
}
