//
//  JobsResponseDTO.swift
//  RemoteRecruit
//
//  Created by Ajay Vyas on 06/06/26.
//

import Foundation

struct JobsResponseDTO: Decodable {
    let jobs: [JobDTO]
}
