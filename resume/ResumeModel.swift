//
//  ResumeModel.swift
//  resume
//
//  Created by horo on 5/22/22.
//

import Foundation

struct ResumeModel: Codable {
    let photoName: String
    let mobile: String
    let email: String
    let address: String
    let objective: String
    let yearOfExperience: Int
    let workSummary: [WorkSummary]
    let skills: [Skill]
    let education: [Education]
    let projects: [Project]
}

struct WorkSummary: Codable {
    let company: String
    let duration: String
}

struct Skill: Codable {
    let skill: String
}

struct Education: Codable {
    let school: String // Not sure the "class" means
    let passingYear: Int
    let CGPA: Double
}

struct Project: Codable {
    let name: String
    let teamSize: Int
    let summary: String
    let usedTech: String
    let role: String
}
