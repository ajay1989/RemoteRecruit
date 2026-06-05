//
//  JobRowView.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import SwiftUI

struct JobRowView: View {
    let job: Job
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppConstants.Spacing.medium) {
            Text(job.title)
                .font(.headline)
            
            Text(job.companyName)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                Label(job.location, systemImage: AppConstants.Icon.location)
                Spacer()
                Text(job.salary)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, AppConstants.Spacing.small)
    }
}
