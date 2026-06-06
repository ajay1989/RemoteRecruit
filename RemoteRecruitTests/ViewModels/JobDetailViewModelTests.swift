//
//  JobDetailViewModelTests.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Testing
import Foundation
@testable import RemoteRecruit

@MainActor
struct JobDetailViewModelTests {
    
    private func makeJob(id: Int = 1, title: String = "iOS Developer") -> Job {
        Job(
            id: id,
            title: title,
            companyName: "Apple",
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
    
    @Test func loadJobSuccess() async throws {
        let service = MockJobsService()
        service.jobsToReturn = [makeJob(id: 1), makeJob(id: 2, title: "Android Dev")]
        let viewModel = JobDetailViewModel(service: service)
        
        viewModel.loadJob(id: 1)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.job?.id == 1)
        #expect(viewModel.job?.title == "iOS Developer")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func loadJobNotFound() async throws {
        let service = MockJobsService()
        service.jobsToReturn = [makeJob(id: 1)]
        let viewModel = JobDetailViewModel(service: service)
        
        viewModel.loadJob(id: 99)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.job == nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test func loadJobFailure() async throws {
        let service = MockJobsService()
        service.shouldThrow = true
        let viewModel = JobDetailViewModel(service: service)
        
        viewModel.loadJob(id: 1)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(viewModel.job == nil)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.isLoading == false)
    }
}
