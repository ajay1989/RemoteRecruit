//
//  JobsServiceTests.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Testing
import Foundation
@testable import RemoteRecruit

struct JobsServiceTests {
    
    private func makeJob(id: Int = 1) -> Job {
        Job(id: id, title: "iOS Dev", companyName: "Apple",
            companyLogoURL: nil, location: "Remote", salary: "",
            jobType: "Full-time", category: "Engineering",
            description: "", publicationDate: Date(), url: nil, tags: [])
    }
    
    @Test func fetchJobsReturnsJobs() async throws {
        let repo = MockJobsRepository()
        repo.jobsToReturn = [makeJob(id: 1), makeJob(id: 2)]
        let service = JobsService(repository: repo)
        let jobs = try await service.fetchJobs()
        #expect(jobs.count == 2)
    }
    
    @Test func refreshJobsInvalidatesCache() async throws {
        let repo = MockJobsRepository()
        repo.jobsToReturn = [makeJob()]
        let service = JobsService(repository: repo)
        _ = try await service.refreshJobs()
        #expect(repo.invalidateCalled == true)
    }
}
