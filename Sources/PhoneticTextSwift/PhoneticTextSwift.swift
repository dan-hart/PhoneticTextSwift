import Foundation

/// A utility for converting strings into their phonetic representations and reversing the conversion.
/// This makes reading out complex codes (like license plates or setup codes) a breeze.
public struct PhoneticTextSwift {
    
    // MARK: - Properties
    
    /// Determines whether to prefix letters with "Capital" or "Lowercase".
    public var includeCasePrefix: Bool
    
    /// Delimiter used when joining multiple phonetic components.
    public var delimiter: String
    
    /// If true, each phonetic component is rendered on a new line.
    public var newLineOutput: Bool
    
    /// Mapping for alphabetic characters (both uppercase and lowercase).
    private static let phoneticMapping: [Character: String] = [
        "A": "Alpha", "B": "Bravo", "C": "Charlie", "D": "Delta",
        "E": "Echo", "F": "Foxtrot", "G": "Golf", "H": "Hotel",
        "I": "India", "J": "Juliett", "K": "Kilo", "L": "Lima",
        "M": "Mike", "N": "November", "O": "Oscar", "P": "Papa",
        "Q": "Quebec", "R": "Romeo", "S": "Sierra", "T": "Tango",
        "U": "Uniform", "V": "Victor", "W": "Whiskey", "X": "Xray",
        "Y": "Yankee", "Z": "Zulu",
        "a": "alpha", "b": "bravo", "c": "charlie", "d": "delta",
        "e": "echo", "f": "foxtrot", "g": "golf", "h": "hotel",
        "i": "india", "j": "juliett", "k": "kilo", "l": "lima",
        "m": "mike", "n": "november", "o": "oscar", "p": "papa",
        "q": "quebec", "r": "romeo", "s": "sierra", "t": "tango",
        "u": "uniform", "v": "victor", "w": "whiskey", "x": "xray",
        "y": "yankee", "z": "zulu"
    ]
    
    /// Mapping for numeric characters.
    private static let digitMapping: [Character: String] = [
        "0": "Zero", "1": "One", "2": "Two", "3": "Three",
        "4": "Four", "5": "Five", "6": "Six", "7": "Seven",
        "8": "Eight", "9": "Niner"
    ]
    
    /// Mapping for special characters found on a standard US keyboard.
    private static let specialMapping: [Character: String] = [
        ";": "Semicolon", ":": "Colon", ",": "Comma", ".": "Period",
        "!": "Exclamation", "?": "Question Mark", "'": "Apostrophe",
        "\"": "Quotation", "(": "Open Parenthesis", ")": "Close Parenthesis",
        "[": "Open Bracket", "]": "Close Bracket", "{": "Open Brace",
        "}": "Close Brace", "-": "Hyphen", "_": "Underscore",
        "+": "Plus", "=": "Equals", "/": "Slash", "\\": "Backslash",
        "*": "Asterisk", "&": "Ampersand", "^": "Caret", "%": "Percent",
        "$": "Dollar", "#": "Hash", "@": "At", "`": "Backtick",
        "~": "Tilde", "<": "Less Than", ">": "Greater Than", "|": "Pipe",
        " ": "Space"
    ]
    
    // MARK: - Initialization
    
    /// Creates a new converter instance with specified formatting options.
    /// - Parameters:
    ///   - includeCasePrefix: If true, letters are prefixed with "Capital" or "Lowercase".
    ///   - delimiter: The delimiter used to join the phonetic components when not using new line output.
    ///   - newLineOutput: If true, each character's conversion appears on a new line.
    public init(includeCasePrefix: Bool = false, delimiter: String = "\n", newLineOutput: Bool = true) {
        self.includeCasePrefix = includeCasePrefix
        self.delimiter = delimiter
        self.newLineOutput = newLineOutput
    }
    
    // MARK: - Public Methods
    
    /// Converts a given string into its phonetic equivalent.
    /// - Parameter input: The source string to convert.
    /// - Returns: A string with each character transformed into its phonetic form, ending with "STOP".
    public func convertToPhonetic(_ input: String) -> String {
        var outputComponents: [String] = []
        
        // Process each character individually.
        for character in input {
            let phoneticRepresentation: String
            if let letterPhonetic = PhoneticTextSwift.phoneticMapping[character] {
                // For letters, optionally add case prefix.
                if includeCasePrefix {
                    let prefix = character.isUppercase ? "Capital" : "Lowercase"
                    phoneticRepresentation = "\(prefix) \(letterPhonetic)"
                } else {
                    phoneticRepresentation = letterPhonetic
                }
                outputComponents.append("\(character): \(phoneticRepresentation)")
            } else if let digitPhonetic = PhoneticTextSwift.digitMapping[character] {
                // For digits, no case prefix is needed.
                phoneticRepresentation = digitPhonetic
                outputComponents.append("\(character): \(phoneticRepresentation)")
            } else if let specialPhonetic = PhoneticTextSwift.specialMapping[character] {
                // For special characters, output without a colon.
                phoneticRepresentation = specialPhonetic
                outputComponents.append("\(character) \(phoneticRepresentation)")
            } else {
                // Fallback for any unmapped characters.
                outputComponents.append("\(character): \(character)")
            }
        }
        
        // Append "STOP" to indicate the end of the conversion.
        outputComponents.append("STOP")
        
        // Join the components with either newline or the provided delimiter.
        return outputComponents.joined(separator: newLineOutput ? "\n" : delimiter)
    }
    
    /// Reverses a phonetic string back into its original form.
    /// - Parameter phoneticString: The phonetic string to reverse.
    /// - Returns: The original string reconstructed from the phonetic components.
    public func reversePhonetic(_ phoneticString: String) -> String {
        // Trim and split the input to remove the trailing "STOP" if present.
        let trimmedString = phoneticString.trimmingCharacters(in: .whitespacesAndNewlines)
        var lines = trimmedString.components(separatedBy: newLineOutput ? "\n" : delimiter)
        if let lastLine = lines.last, lastLine == "STOP" {
            lines.removeLast()
        }
        
        var originalCharacters: [Character] = []
        
        // Process each line to extract the original character.
        for line in lines {
            if let colonIndex = line.firstIndex(of: ":") {
                // For letter and digit mappings.
                let originalChar = line[line.startIndex]
                originalCharacters.append(originalChar)
            } else if let _ = line.firstIndex(of: " ") {
                // For special character mappings.
                let originalChar = line[line.startIndex]
                originalCharacters.append(originalChar)
            } else if !line.isEmpty {
                // Fallback if no delimiter is found.
                originalCharacters.append(line.first!)
            }
        }
        
        return String(originalCharacters)
    }
}
