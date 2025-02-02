import XCTest
@testable import PhoneticTextSwift

final class PhoneticTextSwiftTests: XCTestCase {
    
    // MARK: - Alphabet Tests
    
    /// Tests that the converter correctly transforms all letters.
    func testAlphabetConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("A: Alpha"))
        XCTAssertTrue(output.contains("a: alpha"))
    }
    
    // MARK: - Digit Tests
    
    /// Tests that numeric characters are converted properly.
    func testDigitConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "0123456789"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("0: Zero"))
        // "9" should be "Nine"
        XCTAssertTrue(output.contains("9: Nine"))
    }
    
    // MARK: - Special Character Tests
    
    /// Tests the conversion of special characters from a standard US keyboard.
    func testSpecialCharacterConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let specialCharacters = ";:,.'\"()[]{}-_=+\\/!@#$%^&*`~<>?|"
        let output = converter.convertToPhonetic(specialCharacters)
        
        XCTAssertTrue(output.contains("; Semicolon"))
        XCTAssertTrue(output.contains(": Colon"))
    }
    
    // MARK: - Case Prefix Tests
    
    /// Tests the addition of "Capital" or "lowercase" prefixes when enabled.
    func testCasePrefixConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: true,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "aA"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("a: lowercase alpha"))
        XCTAssertTrue(output.contains("A: Capital Alpha"))
    }
    
    // MARK: - Reverse Conversion Tests
    
    /// Tests that converting to phonetic and then reversing returns the original string.
    func testReverseConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: true,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "xCBDeDe93;dDsQ"
        let phoneticOutput = converter.convertToPhonetic(input)
        let reversed = converter.reversePhonetic(phoneticOutput)
        
        XCTAssertEqual(reversed, input)
    }
    
    // MARK: - Edge Case Tests
    
    /// Tests conversion when an empty string is provided.
    func testEmptyStringConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = ""
        let output = converter.convertToPhonetic(input)
        
        XCTAssertEqual(output, PhoneticConstants.stop)
    }
    
    /// Tests conversion for a string with only whitespace.
    func testWhitespaceConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "   " // Three spaces
        let output = converter.convertToPhonetic(input)
        
        let expected = "SPACE\nSPACE\nSPACE\nSTOP"
        XCTAssertEqual(output, expected)
    }
    
    /// Tests conversion with a custom delimiter (not new line).
    func testCustomDelimiterConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: " | ",
            newLineOutput: false
        )
        let input = "AB"
        let output = converter.convertToPhonetic(input)
        
        XCTAssertTrue(output.contains("A: Alpha | B: Bravo"))
    }
    
    /// Tests conversion of an unmapped character that is an emoji.
    func testEmojiConversion() {
        let converter = PhoneticTextSwift(
            includeCasePrefix: false,
            delimiter: "\n",
            newLineOutput: true
        )
        let input = "🚀"
        let output = converter.convertToPhonetic(input)
        
        let expected = "🚀: Emoji\nSTOP"
        XCTAssertEqual(output, expected)
    }
}
