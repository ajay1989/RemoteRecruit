//
//  HTTPDispatcherProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 05/06/26.
//

import Foundation

protocol HTTPDispatcherProtocol: Sendable {
    func dispatch<T: Decodable>(_ request: URLRequest) async throws -> T
}
