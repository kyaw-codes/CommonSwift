//
//  Encodable.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension Encodable {
    
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dic =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
        } catch {
            return [:]
        }
    }
    
    func encoded(_ encoder: JSONEncoder = .init()) throws -> Data {
        return try encoder.encode(self)
    }
}
