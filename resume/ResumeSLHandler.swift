//
//  ResumeSLHandler.swift
//  resume
//
//  Created by horo on 5/22/22.
//

import Foundation

struct ResumeSLHandler {
    func getDefaultValue() -> ResumeModel {
        ResumeModel(photoName: "", mobile: "", email: "", address: "", objective: "", yearOfExperience: 0, workSummary: [], skills: [], education: [], projects: [])
    }
    
    func save(_ resume: ResumeModel) async -> Bool {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return false
        }
        let path = directory.appendingPathComponent("resume.plist")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(resume)
            try data.write(to: path)
            return true
        } catch {
            return false
        }
    }
    
    func load() async -> ResumeModel? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return nil
        }
        let path = directory.appendingPathComponent("resume.plist")
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: path)
            return try decoder.decode(ResumeModel.self, from: data)
        } catch {
            return nil
        }
    }
}
