//
//  ResumeModel.swift
//  resume
//
//  Created by horo on 5/22/22.
//

import Foundation

struct ResumeModel: Codable {
    var photoName: String
    var mobile: String
    var email: String
    var address: String
    var objective: String
    var yearOfExperience: Int
    var workSummary: [WorkSummary]
    var skills: [Skill]
    var education: [Education]
    var projects: [Project]
}

struct WorkSummary: Codable {
    var company: String
    var duration: String
}

struct Skill: Codable {
    var skill: String
}

struct Education: Codable {
    var school: String // Not sure the "class" means
    var passingYear: Int
    var CGPA: Double
}

struct Project: Codable {
    var name: String
    var teamSize: Int
    var summary: String
    var usedTech: String
    var role: String
}
