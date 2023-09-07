//
//  Double.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : "\(self.digits(count: 2))"
    }
    
    func commaFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    func digits(count: Int) -> Double {
        let divisor = pow(10.0, Double(count))
        let value = (self * divisor).rounded() / divisor
        return value
    }
    
    func round(to decimalPlaces: Int) -> Double {
        let precisionNumber = pow(10,Double(decimalPlaces))
        var n = self // self is a current value of the Double that you will round
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
    
    /// Convert `Double` to coma formatted string with currency symbol
    ///
    ///```
    ///// Return 10,000 $
    ///10000.toCurrency()
    ///
    ///// Return 1.00 $
    ///1.005.toCurrency(with: "$", minimumFractionDigits: 2)
    ///```
    ///
    /// - Parameters:
    ///   - symbol: Currency symbol (Eg- $, €)
    ///   - symbolPositionTrailing: If `true`, the symbol will be attached to the trailing side of the string, otherwise, the leading side
    ///   - default: Default value if anything went wrong
    /// - Returns: Currency string
    func toCurrency(with symbol: String = "$", symbolPositionTrailing: Bool = true, default: String = "", minimumFractionDigits: Int = 0) -> String {
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
        formatter.minimumFractionDigits = minimumFractionDigits
        return formatter.string(from: NSNumber(value: self)).orElse(`default`)
    }
}
