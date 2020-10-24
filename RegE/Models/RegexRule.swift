//
//  RegexRule.swift
//  RegE
//
//  Created by Patrick Huffer on 2020-08-18.
//

import Foundation

struct RegexRule: Hashable, Codable, Identifiable {
    //  swiftlint:disable identifier_name
    var id: Int
    //  swiftlint:enable identifier_name
    var description: String
    var pattern: String
}
