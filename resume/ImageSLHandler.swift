//
//  ImageSLHandler.swift
//  resume
//
//  Created by horo on 5/21/22.
//

import Foundation
import UIKit

struct ImageSLHandler {
    func saveTo(_ subpath: String, with image: UIImage) async -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return false
        }
        
        do {
            try data.write(to: directory.appendingPathComponent(subpath))
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func loadFrom(_ subpath: String) async -> UIImage? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return nil
        }
        
        let pathURL = directory.appendingPathComponent(subpath)
        return UIImage(contentsOfFile: pathURL.path)
    }
}
