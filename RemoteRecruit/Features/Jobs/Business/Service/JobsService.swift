//
//  JobsService.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

actor JobsService: JobsServiceProtocol {
    
    private let repository: JobsRepositoryProtocol
    
    init(repository: JobsRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchJobs() async throws -> [Job] {
        try await repository.fetchJobs()
    }
    
    func refreshJobs() async throws -> [Job] {
        // Invalidate cache before fetching to force fresh data
        await repository.invalidateCache()
        return try await repository.fetchJobs()
    }
}
