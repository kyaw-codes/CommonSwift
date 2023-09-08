//
//  Comparable.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension Comparable {
    
    mutating func clamp(minimum:Self, maximum:Self) {
        if self < minimum { self = minimum }
        if self > maximum { self = maximum }
    }
}
