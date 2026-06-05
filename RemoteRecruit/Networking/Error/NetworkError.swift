//
//  NetworkError.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 05/06/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noInternet
    case decodingFailed
    case serverError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .noInternet:
            return "No internet connection"
        case .decodingFailed:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}
