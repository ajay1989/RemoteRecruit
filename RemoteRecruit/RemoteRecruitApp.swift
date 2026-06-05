//
//  RemoteRecruitApp.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 05/06/26.
//

import SwiftUI

@main
struct RemoteRecruitApp: App {
    var body: some Scene {
        WindowGroup {
            JobListScreen(
                viewModel: AppContainer.shared.makeJobListViewModel()
            )
        }
    }
}
