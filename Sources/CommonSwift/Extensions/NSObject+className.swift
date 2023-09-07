//
//  NSObject+className.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension NSObject {
    
    /// Retrieve the class name as `String`
    var className: String {
        String(describing: type(of: self))
    }
    
    /// Retrieve the class name as `String`
    class var className: String {
        String(describing: self)
    }
}

