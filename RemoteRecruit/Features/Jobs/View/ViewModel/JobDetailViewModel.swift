//
//  JobDetailViewModel.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation
import Observation

@Observable
final class JobDetailViewModel {
    var job: Job?
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let service: JobsServiceProtocol
    // Cancels previous request before starting a new one
    private var loadTask: Task<Void, Never>?
    
    init(service: JobsServiceProtocol) {
        self.service = service
    }
    
    func loadJob(id: Int) {
        loadTask?.cancel()
        loadTask = Task {
            isLoading = true
            errorMessage = nil
            do {
                let jobs = try await service.fetchJobs()
                job = jobs.first { $0.id == id }
            } catch {
                if !Task.isCancelled {
                    errorMessage = error.localizedDescription
                }
            }
            if !Task.isCancelled { isLoading = false }
        }
    }
}
