//
//  JobsRemoteDataSourceProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

protocol JobsRemoteDataSourceProtocol: Sendable {
    func fetchJobs() async throws -> [Job]
}
