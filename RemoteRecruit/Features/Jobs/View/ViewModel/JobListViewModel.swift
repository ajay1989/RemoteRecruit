//
//  JobListViewModel.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation
import Observation

@Observable
final class JobListViewModel {
    var jobs: [Job] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    // Filters locally without extra network call
    var filteredJobs: [Job] {
        if searchText.isEmpty { return jobs }
        return jobs.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.companyName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var isEmpty: Bool {
        !isLoading && filteredJobs.isEmpty && errorMessage == nil
    }
    
    private let service: JobsServiceProtocol
    // Cancels previous request before starting a new one
    private var loadTask: Task<Void, Never>?
    
    init(service: JobsServiceProtocol) {
        self.service = service
    }
    
    func loadJobs() {
        loadTask?.cancel()
        loadTask = Task {
            isLoading = true
            errorMessage = nil
            do {
                jobs = try await service.fetchJobs()
            } catch {
                if !Task.isCancelled {
                    errorMessage = error.localizedDescription
                }
            }
            if !Task.isCancelled { isLoading = false }
        }
    }
    
    func refreshJobs() {
        loadTask?.cancel()
        loadTask = Task {
            isLoading = true
            errorMessage = nil
            do {
                jobs = try await service.refreshJobs()
            } catch {
                if !Task.isCancelled {
                    errorMessage = error.localizedDescription
                }
            }
            if !Task.isCancelled { isLoading = false }
        }
    }
}
