//
//  Constants.swift
//  PhoneticTextSwift
//
//  Created by Dan Hart on 2/2/25.
//

import Foundation

// MARK: - Constants
/// These constants define special tokens used in phonetic conversion.
/// Defining them as constants makes it easy to change these values later if needed.
public enum PhoneticConstants {
    /// The token indicating the end of the conversion.
    public static let stop: String = "STOP"
    /// The token representing a space character in the conversion output.
    public static let space: String = "SPACE"
}
