# PhoneticTextSwift

PhoneticTextSwift is a Swift package designed to convert any string into a clear, human-readable phonetic representation. Whether you're reciting a complex license plate, a setup code, or an email address over the phone, this package has you covered.

## Features

- **Phonetic Conversion:** Transform letters (e.g., "A" becomes "Alpha"), digits (e.g., "9" becomes "Niner"), and special characters into easy-to-read text.
- **Case Sensitivity:** Optionally prefix letters with "Capital" or "Lowercase" to emphasize their case.
- **Flexible Output:** Choose between new-line separated output or a custom-delimited string.
- **Reverse Conversion:** Convert phonetic strings back to their original form.
- **Extensible:** Written with English in mind but designed for easy localization for future languages.
- **Well-Tested:** Extensive test cases covering all letters, digits, and special characters.

## Supported Platforms

This package supports the following platforms:
- iOS (v14+)
- macOS (v13+)
- macCatalyst (v13+)
- tvOS (v14+)
- watchOS (v7+)
- visionOS (v1+)

## Installation

Add PhoneticTextSwift to your dependencies in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/PhoneticTextSwift.git", from: "1.0.0")
]
```

## Usage

```swift
import PhoneticTextSwift

// Create a converter with your preferred options.
let converter = PhoneticTextSwift(
    includeCasePrefix: true,
    delimiter: "\n",
    newLineOutput: true
)

let inputString = "xCBDeDe93;dDsQ"

// Convert the input string to its phonetic representation.
let phoneticString = converter.convertToPhonetic(inputString)
print(phoneticString)

/* Example Output:
x: xray
C: Charlie
B: Bravo
D: Delta
e: echo
D: Delta
e: echo
9: Nine
3: Three
; Semicolon
d: delta
D: Delta
s: sierra
Q: Quebec
STOP
*/

// Reverse the phonetic string back to the original.
let originalString = converter.reversePhonetic(phoneticString)
print(originalString) // xCBDeDe93;dDsQ
```

## Testing

Run the test suite to verify everything works as expected:
```bash
swift test
```

## Contributing

Contributions are welcome! Please open an issue or pull request if you have any suggestions or improvements.

## License

GNU General Public License v3.0
See [LICENSE](LICENSE) for more information.

