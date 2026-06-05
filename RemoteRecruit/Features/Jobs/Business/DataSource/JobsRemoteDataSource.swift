//
//  JobsRemoteDataSource.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

actor JobsRemoteDataSource: JobsRemoteDataSourceProtocol {
    
    private let dispatcher: HTTPDispatcherProtocol
    
    init(dispatcher: HTTPDispatcherProtocol) {
        self.dispatcher = dispatcher
    }
    
    func fetchJobs() async throws -> [Job] {
        guard let url = URL(string: AppConstants.API.baseURL + "/remote-jobs") else {
            throw NetworkError.invalidURL
        }
        // Fresh request every time, no local cache interference
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let response: JobsResponseDTO = try await dispatcher.dispatch(request)
        return response.jobs.map { $0.toDomain() }
    }
}
