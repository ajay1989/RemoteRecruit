//
//  JobListScreen.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import SwiftUI

struct JobListScreen: View {
    
    @State var viewModel: JobListViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(AppConstants.Strings.jobsTitle)
                .searchable(text: $viewModel.searchText, prompt: AppConstants.Strings.searchPrompt)
                .refreshable {
                    viewModel.refreshJobs()
                }
        }
        .task {
            viewModel.loadJobs()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage {
            ContentUnavailableView(error, systemImage: AppConstants.Icon.error)
        } else if viewModel.isEmpty {
            ContentUnavailableView(AppConstants.Strings.noJobsFound, systemImage: AppConstants.Icon.emptyJobs)
        } else {
            List(viewModel.filteredJobs) { job in
                NavigationLink(value: job) {
                    JobRowView(job: job)
                }
            }
            .navigationDestination(for: Job.self) { job in
                JobDetailScreen(
                    viewModel: AppContainer.shared.makeJobDetailViewModel(),
                    job: job
                )
            }
        }
    }
}
