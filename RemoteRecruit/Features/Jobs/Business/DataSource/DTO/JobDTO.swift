//
//  JobDTO.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

struct JobDTO: Decodable {
    let id: Int
    let url: String
    let title: String
    let companyName: String
    let companyLogo: String?
    let category: String
    let tags: [String]
    let jobType: String
    let publicationDate: String
    let candidateRequiredLocation: String
    let salary: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, url, title, category, tags, salary, description
        case companyName = "company_name"
        case companyLogo = "company_logo"
        case jobType = "job_type"
        case publicationDate = "publication_date"
        case candidateRequiredLocation = "candidate_required_location"
    }
    
    func toDomain() -> Job {
        Job(
            id: id,
            title: title,
            companyName: companyName,
            companyLogoURL: companyLogo.flatMap { URL(string: $0) },
            location: candidateRequiredLocation.isEmpty ? "Worldwide" : candidateRequiredLocation,
            salary: salary.isEmpty ? "Not specified" : salary,
            jobType: jobType,
            category: category,
            description: description,
            publicationDate: ISO8601DateFormatter().date(from: publicationDate) ?? Date(),
            url: URL(string: url),
            tags: tags
        )
    }
}
