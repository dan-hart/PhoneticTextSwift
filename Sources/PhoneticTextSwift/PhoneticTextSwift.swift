import Foundation

/// Extension to detect if a Character is an Emoji.
/// Emojis are not fully handled by this package; when encountered,
/// the output will simply state "Emoji" for that character.
extension Character {
    var isEmoji: Bool {
        return self.unicodeScalars.contains { scalar in
            scalar.properties.isEmoji && scalar.value > 0x238C
        }
    }
}

/// A utility for converting strings into their phonetic representations and reversing the conversion.
/// This makes reading out complex codes (like license plates or setup codes) a breeze.
///
/// **Notes:**
/// - The digit "9" is represented as "Nine".
/// - When case prefixing is enabled, lowercase letters are prefixed with "lowercase" while uppercase letters use "Capital".
/// - Spaces in the source string are represented as `SPACE` (without a colon).
/// - Emojis are not fully handled; they appear as the emoji followed by "Emoji".
public struct PhoneticTextSwift {
    
    // MARK: - Properties
    
    public var includeCasePrefix: Bool
    public var delimiter: String
    public var newLineOutput: Bool
    
    // MARK: - Static Mappings
    
    private static let phoneticMapping: [Character: String] = [
        "A": "Alpha",
        "B": "Bravo",
        "C": "Charlie",
        "D": "Delta",
        "E": "Echo",
        "F": "Foxtrot",
        "G": "Golf",
        "H": "Hotel",
        "I": "India",
        "J": "Juliett",
        "K": "Kilo",
        "L": "Lima",
        "M": "Mike",
        "N": "November",
        "O": "Oscar",
        "P": "Papa",
        "Q": "Quebec",
        "R": "Romeo",
        "S": "Sierra",
        "T": "Tango",
        "U": "Uniform",
        "V": "Victor",
        "W": "Whiskey",
        "X": "Xray",
        "Y": "Yankee",
        "Z": "Zulu",
        "a": "alpha",
        "b": "bravo",
        "c": "charlie",
        "d": "delta",
        "e": "echo",
        "f": "foxtrot",
        "g": "golf",
        "h": "hotel",
        "i": "india",
        "j": "juliett",
        "k": "kilo",
        "l": "lima",
        "m": "mike",
        "n": "november",
        "o": "oscar",
        "p": "papa",
        "q": "quebec",
        "r": "romeo",
        "s": "sierra",
        "t": "tango",
        "u": "uniform",
        "v": "victor",
        "w": "whiskey",
        "x": "xray",
        "y": "yankee",
        "z": "zulu",
    ]
    
    private static let digitMapping: [Character: String] = [
        "0": "Zero",
        "1": "One",
        "2": "Two",
        "3": "Three",
        "4": "Four",
        "5": "Five",
        "6": "Six",
        "7": "Seven",
        "8": "Eight",
        "9": "Nine",
    ]
    
    private static let specialMapping: [Character: String] = [
        ";": "Semicolon",
        ":": "Colon",
        ",": "Comma",
        ".": "Period",
        "!": "Exclamation",
        "?": "Question Mark",
        "'": "Apostrophe",
        "\"": "Quotation",
        "(": "Open Parenthesis",
        ")": "Close Parenthesis",
        "[": "Open Bracket",
        "]": "Close Bracket",
        "{": "Open Brace",
        "}": "Close Brace",
        "-": "Hyphen",
        "_": "Underscore",
        "+": "Plus",
        "=": "Equals",
        "/": "Slash",
        "\\": "Backslash",
        "*": "Asterisk",
        "&": "Ampersand",
        "^": "Caret",
        "%": "Percent",
        "$": "Dollar",
        "#": "Hash",
        "@": "At",
        "`": "Backtick",
        "~": "Tilde",
        "<": "Less Than",
        ">": "Greater Than",
        "|": "Pipe",
    ]
    
    // MARK: - Initialization
    
    public init(
        includeCasePrefix: Bool = false,
        delimiter: String = "\n",
        newLineOutput: Bool = true
    ) {
        self.includeCasePrefix = includeCasePrefix
        self.delimiter = delimiter
        self.newLineOutput = newLineOutput
    }
    
    // MARK: - Public Methods
    
    public func convertToPhonetic(_ input: String) -> String {
        var outputComponents: [String] = []
        
        for character in input {
            if character == " " {
                outputComponents.append(PhoneticConstants.space)
                continue
            }
            
            if character.isEmoji {
                outputComponents.append("\(character): Emoji")
            } else if let letterPhonetic = PhoneticTextSwift.phoneticMapping[character] {
                let phoneticRepresentation: String
                if includeCasePrefix {
                    let prefix = character.isUppercase ? "Capital" : "lowercase"
                    phoneticRepresentation = "\(prefix) \(letterPhonetic)"
                } else {
                    phoneticRepresentation = letterPhonetic
                }
                outputComponents.append("\(character): \(phoneticRepresentation)")
            } else if let digitPhonetic = PhoneticTextSwift.digitMapping[character] {
                outputComponents.append("\(character): \(digitPhonetic)")
            } else if let specialPhonetic = PhoneticTextSwift.specialMapping[character] {
                outputComponents.append("\(character) \(specialPhonetic)")
            } else {
                outputComponents.append("\(character): \(character)")
            }
        }
        
        outputComponents.append(PhoneticConstants.stop)
        return outputComponents.joined(separator: newLineOutput ? "\n" : delimiter)
    }
    
    public func reversePhonetic(_ phoneticString: String) -> String {
        let trimmedString = phoneticString.trimmingCharacters(in: .whitespacesAndNewlines)
        var lines = trimmedString.components(separatedBy: newLineOutput ? "\n" : delimiter)
        if let lastLine = lines.last, lastLine == PhoneticConstants.stop {
            lines.removeLast()
        }
        
        var originalCharacters: [Character] = []
        for line in lines {
            if line == PhoneticConstants.space {
                originalCharacters.append(" ")
            } else if line.firstIndex(of: ":") != nil {
                let originalChar = line[line.startIndex]
                originalCharacters.append(originalChar)
            } else if !line.isEmpty {
                originalCharacters.append(line.first!)
            }
        }
        return String(originalCharacters)
    }
}
