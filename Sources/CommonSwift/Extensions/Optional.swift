//
//  Optional.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 07/09/2023.
//

import Foundation

public extension Optional {
    
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return self != nil
    }
    
    func then(_ f: (Wrapped) -> Void) {
        switch self {
        case .some(let value):
            f(value)
        case .none:
            return
        }
    }
    
    func apply<B>(_ f: ((Wrapped) -> B)?) -> B? {
        switch (f, self) {
        case let (.some(fx), _):
            return self.map(fx)
        default:
            return .none
        }
    }
    
    func orElse(_ x: Wrapped) -> Wrapped {
        switch self {
        case .none: return x
        case .some(let v): return v
        }
    }
    
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else {
            throw errorExpression()
        }
        
        return value
    }
    
    func matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self else {
            return nil
        }
        
        guard predicate(value) else {
            return nil
        }
        
        return value
    }
    
    static func pure(_ x: Wrapped) -> Optional {
        .some(x)
    }
    
    static func zip<A, B>(_ x: A?, _ y: B?) -> (A, B)? {
        switch (x, y) {
        case let (.some(x), .some(y)):
            return .some((x, y))
        default:
            return nil
            
        }
    }
}

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped == String {
    
    var orEmpty: String {
        switch self {
        case .none: return ""
        case .some(let v): return v
        }
    }
}

public extension Optional where Wrapped == Double {
    
    var orZero: Double {
        switch self {
        case .none: return 0
        case .some(let v): return v
        }
    }
}

public extension Optional where Wrapped == Int {
    
    var orZero: Int {
        switch self {
        case .none: return 0
        case .some(let v): return v
        }
    }
}

