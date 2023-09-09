//
//  StringExtensionsTest.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 09/09/2023.
//

import XCTest
@testable import CommonSwift

final class StringExtensionsTest: XCTestCase {

    func test_staticEmptyProp_returnEmptyString() {
        XCTAssertEqual(String.empty, "")
    }
    
    func test_strWithWhiteSpaces_whenFiltered_returnSpaceRemovedString() {
        XCTAssertEqual("1 2  34".spaceRemoved, "1234")
    }
    
    func test_strWithDots_whenFiltered_returnDotsRemovedString() {
        XCTAssertEqual("1.2.34".dotRemoved, "1234")
    }
    
    func test_strWithSpacesAndDots_whenFiltered_returnProperString() {
        XCTAssertEqual("1. 2..3 4".spaceRemoved.dotRemoved, "1234")
        XCTAssertEqual("a b.c. d".dotRemoved.spaceRemoved, "abcd")
    }
    
    func test_withValidUrl_returnURLObject() {
        let url = "https://www.apple.com"
        XCTAssertNotNil(url.url)
    }
    
    func test_withValidNumericString_whenTypeCast_convertToRespectiveNumericType() {
        let intStr = "12"
        let doubleStr = "10.1"
        
        XCTAssertNotNil(intStr.toInt)
        XCTAssertEqual(intStr.toInt, 12)
        
        XCTAssertNotNil(doubleStr.toDouble)
        XCTAssertEqual(doubleStr.toDouble, 10.1)
    }
 
    func test_string_whenIsNotEmptyCalled_returnCorrespondingBool() {
        XCTAssertTrue("Hello".isNotEmpty)
        XCTAssertFalse("".isNotEmpty)
    }
    
    func test_string_whenFirstLetterCapitalized_getFirstLetterCapitalizedStr() {
        XCTAssertEqual("hello".firstLetterCapitalized, "Hello")
    }
    
    func test_string_convertToBool_returnRespectiveBoolValue() {
        let _true = "true"
        let yes = "yes"
        let _1 = "1"
        
        let _false = "false"
        let no = "no"
        let _0 = "0"
        
        XCTAssertNotNil(_true.toBool())
        XCTAssertNotNil(yes.toBool())
        XCTAssertNotNil(_1.toBool())
        XCTAssertNotNil(_false.toBool())
        XCTAssertNotNil(no.toBool())
        XCTAssertNotNil(_0.toBool())
        
        XCTAssertNil("lol".toBool())
        
        XCTAssertEqual(_true.toBool(), true)
        XCTAssertEqual(yes.toBool(), true)
        XCTAssertEqual(_1.toBool(), true)
        
        XCTAssertEqual(_false.toBool(), false)
        XCTAssertEqual(no.toBool(), false)
        XCTAssertEqual(_0.toBool(), false)
    }
    
    func test_string_whenSubString_returnAppropriateSubString() {
        let string = "Hello, World!"
        XCTAssertEqual(string.substring(from: nil, to: nil), "Hello, World!")
        XCTAssertEqual(string.substring(from: nil, to: 7), "Hello, W")
        XCTAssertEqual(string.substring(from: 2, to: nil), "llo, World!")
        XCTAssertEqual(string.substring(from: 2, to: 7), "llo, W")
        XCTAssertEqual(string.substring(from: -2, to: 4), "Hello")
        XCTAssertEqual(string.substring(from: -5, to: -1), "")
        XCTAssertEqual(string.substring(from: 15, to: 20), "")
    }
    
    func test_localTimeString_toUTCTimeStamp_convertAppropriateUTCTime() {
        let localTime = "14:00"
        XCTAssertEqual(localTime.convertToUTCTimestamp(), "07:30")
    }
    
    func test_mailString_isValidEmail_canValidateAccordingly() {
        XCTAssertFalse("".isValidEmail())
        XCTAssertFalse("aaa".isValidEmail())
        XCTAssertFalse("aaa.com".isValidEmail())
        XCTAssertFalse("@aaa.com".isValidEmail())
        XCTAssertFalse("aaa.com@".isValidEmail())
        XCTAssertFalse("aaa.com@.a".isValidEmail())
        XCTAssertFalse("hello@swift.io".isValidEmail(forCustomDomains: ["gmail.com"]))
        XCTAssertFalse("hello@yahoo.lol".isValidEmail(
            forCustomDomains: ["gmail.com", "yahoo.com", "contoso.com"]))
        
        XCTAssertTrue("hello@swift.io".isValidEmail())
        XCTAssertTrue("hello@swift.io".isValidEmail(forCustomDomains: []))
        XCTAssertTrue("hello@gmail.com".isValidEmail(forCustomDomains: ["gmail.com"]))
        XCTAssertTrue("hello@yahoo.com".isValidEmail(
            forCustomDomains: ["gmail.com", "yahoo.com", "contoso.com"]))
    }
}
