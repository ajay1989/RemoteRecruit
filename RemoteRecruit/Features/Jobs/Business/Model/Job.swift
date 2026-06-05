//
//  Job.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 05/06/26.
//

import Foundation

// Sendable allows Job to be passed safely across actor boundaries
struct Job: Identifiable, Hashable, Sendable {
    let id: Int
    let title: String
    let companyName: String
    let companyLogoURL: URL?
    let location: String
    let salary: String
    let jobType: String
    let category: String
    let description: String
    let publicationDate: Date
    let url: URL?
    let tags: [String]
}
