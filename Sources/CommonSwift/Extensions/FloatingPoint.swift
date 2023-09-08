//
//  FloatingPoint.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 08/09/2023.
//

import Foundation

public extension FloatingPoint {
    
    var isInteger: Bool {
        rounded() == self
    }
}
