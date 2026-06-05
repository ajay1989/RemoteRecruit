//
//  JobsRepository.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

actor JobsRepository: JobsRepositoryProtocol {
    
    private enum CacheKey {
        static let jobs = "jobs"
    }
    
    private let remoteDataSource: JobsRemoteDataSourceProtocol
    // Cache stores full job list, keyed by a fixed string
    private let cache = LRUCache<String, [Job]>(capacity: 10)
    
    init(remoteDataSource: JobsRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchJobs() async throws -> [Job] {
        // Return cached result to avoid duplicate network calls
        if let cached = await cache.get(CacheKey.jobs) {
            return cached
        }
        let jobs = try await remoteDataSource.fetchJobs()
        await cache.set(CacheKey.jobs, value: jobs)
        return jobs
    }
    
    func invalidateCache() async {
        await cache.invalidate()
    }
}
