//
//  AppConstants.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

enum AppConstants {
    enum API {
        static let baseURL = "https://remotive.com/api"
    }
    
    enum Icon {
        static let location = "location"
        static let error = "exclamationmark.triangle"
        static let emptyJobs = "briefcase"
        static let company = "building.2"
        static let salary = "dollarsign.circle"
        static let jobType = "clock"
    }
    
    enum Spacing {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 16
        static let logoHeight: CGFloat = 60
    }
    
    enum Strings {
        static let jobsTitle = "Jobs"
        static let searchPrompt = "Search by title or company"
        static let noJobsFound = "No Jobs Found"
        static let aboutRole = "About the Role"
        static let applyNow = "Apply Now"
    }
}
