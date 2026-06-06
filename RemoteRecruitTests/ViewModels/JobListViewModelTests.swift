//
//  JobListViewModelTests.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Testing
import Foundation
@testable import RemoteRecruit

@MainActor
struct JobListViewModelTests {
    
    private func makeJob(id: Int = 1, title: String = "iOS Developer", company: String = "Apple") -> Job {
        Job(
            id: id,
            title: title,
            companyName: company,
            companyLogoURL: nil,
            location: "Remote",
            salary: "",
            jobType: "Full-time",
            category: "Engineering",
            description: "",
            publicationDate: Date(),
            url: nil,
            tags: []
        )
    }
    
    @Test func loadJobsSuccess() async throws {
        let service = MockJobsService()
        service.jobsToReturn = [makeJob(id: 1), makeJob(id: 2)]
        let viewModel = JobListViewModel(service: service)
        
        viewModel.loadJobs()
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.jobs.count == 2)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func loadJobsFailure() async throws {
        let service = MockJobsService()
        service.shouldThrow = true
        let viewModel = JobListViewModel(service: service)
        
        viewModel.loadJobs()
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.jobs.isEmpty)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test func filteredJobsByTitle() async throws {
        let service = MockJobsService()
        service.jobsToReturn = [makeJob(title: "iOS Developer"), makeJob(id: 2, title: "Android Dev")]
        let viewModel = JobListViewModel(service: service)
        
        viewModel.loadJobs()
        try await Task.sleep(for: .milliseconds(100))

        // Set searchText and wait for 300ms debounce to fire
        viewModel.searchText = "iOS"
        try await Task.sleep(for: .milliseconds(400))

        #expect(viewModel.filteredJobs.count == 1)
        #expect(viewModel.filteredJobs.first?.title == "iOS Developer")
    }
    
    @Test func refreshJobsCallsService() async throws {
        let service = MockJobsService()
        service.jobsToReturn = [makeJob()]
        let viewModel = JobListViewModel(service: service)
        
        viewModel.refreshJobs()
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(service.refreshCallCount == 1)
        #expect(viewModel.jobs.count == 1)
    }
}
