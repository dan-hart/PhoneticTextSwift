import XCTest
@testable import PhoneticTextSwift

final class PhoneticTextSwiftTests: XCTestCase {
    
    // MARK: - Alphabet Tests
    
    /// Tests that the converter correctly transforms all letters.
    func testAlphabetConversion() {
        let converter = PhoneticTextSwift(includeCasePrefix: false, newLineOutput: true)
        let input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("A: Alpha"))
        XCTAssertTrue(output.contains("a: alpha"))
    }
    
    // MARK: - Digit Tests
    
    /// Tests that numeric characters are converted properly.
    func testDigitConversion() {
        let converter = PhoneticTextSwift(includeCasePrefix: false, newLineOutput: true)
        let input = "0123456789"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("0: Zero"))
        XCTAssertTrue(output.contains("9: Niner"))
    }
    
    // MARK: - Special Character Tests
    
    /// Tests the conversion of special characters from a standard US keyboard.
    func testSpecialCharacterConversion() {
        let converter = PhoneticTextSwift(includeCasePrefix: false, newLineOutput: true)
        let specialCharacters = ";:,.'\"()[]{}-_=+\\/!@#$%^&*`~<>?|"
        let output = converter.convertToPhonetic(specialCharacters)
        
        XCTAssertTrue(output.contains("; Semicolon"))
        XCTAssertTrue(output.contains(": Colon"))
    }
    
    // MARK: - Case Prefix Tests
    
    /// Tests the addition of "Capital" or "Lowercase" prefixes when enabled.
    func testCasePrefixConversion() {
        let converter = PhoneticTextSwift(includeCasePrefix: true, newLineOutput: true)
        let input = "aA"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("a: Lowercase alpha"))
        XCTAssertTrue(output.contains("A: Capital Alpha"))
    }
    
    // MARK: - Reverse Conversion Tests
    
    /// Tests that converting to phonetic and then reversing returns the original string.
    func testReverseConversion() {
        let converter = PhoneticTextSwift(includeCasePrefix: true, newLineOutput: true)
        let input = "xCBDeDe93;dDsQ"
        let phoneticOutput = converter.convertToPhonetic(input)
        let reversed = converter.reversePhonetic(phoneticOutput)
        
        XCTAssertEqual(reversed, input)
    }
}
