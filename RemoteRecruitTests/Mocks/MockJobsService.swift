//
//  MockJobsService.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation
@testable import RemoteRecruit

final class MockJobsService: JobsServiceProtocol {
    var jobsToReturn: [Job] = []
    var shouldThrow: Bool = false
    var fetchCallCount: Int = 0
    var refreshCallCount: Int = 0
    
    func fetchJobs() async throws -> [Job] {
        fetchCallCount += 1
        if shouldThrow { throw NetworkError.noInternet }
        return jobsToReturn
    }
    
    func refreshJobs() async throws -> [Job] {
        refreshCallCount += 1
        if shouldThrow { throw NetworkError.noInternet }
        return jobsToReturn
    }
}
