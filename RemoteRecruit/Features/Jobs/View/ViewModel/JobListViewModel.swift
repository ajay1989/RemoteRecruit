//
//  JobListViewModel.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation
import Observation
import Combine

@Observable
final class JobListViewModel {
    var jobs: [Job] = []
    var searchText: String = "" {
        didSet { searchSubject.send(searchText) }
    }
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private(set) var debouncedSearchText: String = ""
    
    // Filters locally without extra network call
    var filteredJobs: [Job] {
        if debouncedSearchText.isEmpty { return jobs }
        return jobs.filter {
            $0.title.localizedCaseInsensitiveContains(debouncedSearchText) ||
            $0.companyName.localizedCaseInsensitiveContains(debouncedSearchText)
        }
    }
    
    var isEmpty: Bool {
        !isLoading && filteredJobs.isEmpty && errorMessage == nil
    }
    
    private let service: JobsServiceProtocol
    // Cancels previous request before starting a new one
    private var loadTask: Task<Void, Never>?
    private let searchSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(service: JobsServiceProtocol) {
        self.service = service
        setupSearchDebounce()
    }
    
    // Delays search to avoid filtering on every keystroke
    private func setupSearchDebounce() {
        searchSubject
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.debouncedSearchText = text
            }
            .store(in: &cancellables)
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
