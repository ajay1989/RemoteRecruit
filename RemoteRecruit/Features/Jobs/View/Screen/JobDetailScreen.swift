//
//  JobDetailScreen.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import SwiftUI

struct JobDetailScreen: View {
    let viewModel: JobDetailViewModel
    let job: Job
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppConstants.Spacing.large) {
                headerSection
                Divider()
                infoSection
                Divider()
                descriptionSection
                applyButton
            }
            .padding(AppConstants.Spacing.large)
        }
        .navigationTitle(job.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.small) {
            Image(systemName: AppConstants.Icon.company)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            Text(job.title)
                .font(.title2)
                .bold()
            
            Text(job.companyName)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.medium) {
            Label(job.location, systemImage: AppConstants.Icon.location)
            Label(job.salary, systemImage: AppConstants.Icon.salary)
            Label(job.jobType, systemImage: AppConstants.Icon.jobType)
        }
        .font(.subheadline)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.medium) {
            Text(AppConstants.Strings.aboutRole)
                .font(.headline)
            Text(job.description.strippedHTML)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder
    private var applyButton: some View {
        if let url = job.url {
            Link(AppConstants.Strings.applyNow, destination: url)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding(.top, AppConstants.Spacing.medium)
        }
    }
}
