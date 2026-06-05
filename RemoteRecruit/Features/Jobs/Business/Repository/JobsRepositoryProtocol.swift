//
//  JobsRepositoryProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

protocol JobsRepositoryProtocol: Sendable {
    func fetchJobs() async throws -> [Job]
    func invalidateCache() async
}
