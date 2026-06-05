//
//  JobsServiceProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

protocol JobsServiceProtocol: Sendable {
    func fetchJobs() async throws -> [Job]
    func refreshJobs() async throws -> [Job]
}
