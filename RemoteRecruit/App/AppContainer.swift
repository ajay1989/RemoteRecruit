//
//  AppContainer.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

@MainActor
final class AppContainer {
    
    static let shared = AppContainer()
    
    private let jobsService: JobsServiceProtocol
    
    private init() {
        let dispatcher = HTTPDispatcher()
        let dataSource = JobsRemoteDataSource(dispatcher: dispatcher)
        let repository = JobsRepository(remoteDataSource: dataSource)
        jobsService = JobsService(repository: repository)
    }
    
    func makeJobListViewModel() -> JobListViewModel {
        JobListViewModel(service: jobsService)
    }
    
    func makeJobDetailViewModel() -> JobDetailViewModel {
        JobDetailViewModel(service: jobsService)
    }
}
