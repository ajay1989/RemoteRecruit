//
//  MockJobsRepository.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation
@testable import RemoteRecruit

final class MockJobsRepository: JobsRepositoryProtocol {
    var jobsToReturn: [Job] = []
    var shouldThrow: Bool = false
    var invalidateCalled: Bool = false
    
    func fetchJobs() async throws -> [Job] {
        if shouldThrow { throw NetworkError.noInternet }
        return jobsToReturn
    }
    
    func invalidateCache() async {
        invalidateCalled = true
    }
}
