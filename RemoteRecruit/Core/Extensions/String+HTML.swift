//
//  String+HTML.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

extension String {
    // HTML tags stripped for plain text rendering
    var strippedHTML: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
