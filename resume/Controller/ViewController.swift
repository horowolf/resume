//
//  ViewController.swift
//  resume
//
//  Created by horo on 5/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var resume = ResumeSLHandler().getDefaultValue()
    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.isScrollEnabled = true
        image.image = UIImage(named: "noimage_png")
        
        textView.isEditable = false
        self.stackView.addArrangedSubview(textView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            if let resumeData = await ResumeSLHandler().load() {
                resume = resumeData
                if let loadedImage = await ImageSLHandler().loadFrom(resume.photoName) {
                    image.image = loadedImage
                }
                var text = ""
                
                text = text + "Mobile: \(resume.mobile)\n"
                text = text + "Email: \(resume.email)\n"
                text = text + "Address: \(resume.address)\n"
                text = text + "Objective: \(resume.objective)\n"
                text = text + "Years of experience: \(resume.yearOfExperience)\n"
                
                text = text + "Work Summary:\n"
                text = text + "================\n"
                for work in resume.workSummary {
                    text = text + "\tCompany name: \(work.company)\n"
                    text = text + "\tDuration: \(work.duration)\n"
                    text = text + "\n"
                }
                
                text = text + "Skills:\n"
                text = text + "================\n"
                for skill in resume.skills {
                    text = text + "\t\(skill.skill)\n"
                }
                
                text = text + "Education details:\n"
                text = text + "================\n"
                for education in resume.education {
                    text = text + "\tSchool name: \(education.school)\n"
                    text = text + "\tPassing year: \(education.passingYear)\n"
                    text = text + "\tCGPA: \(education.CGPA)\n"
                    text = text + "\n"
                }
                
                text = text + "Project details:\n"
                text = text + "================\n"
                for project in resume.projects {
                    text = text + "\tProject name: \(project.name)\n"
                    text = text + "\tTeam size: \(project.teamSize)\n"
                    text = text + "\tProject summary: \(project.summary)\n"
                    text = text + "\tTechnology used: \(project.usedTech)\n"
                    text = text + "\tRole: \(project.role)\n"
                    text = text + "\n"
                }
                
                textView.text = text
            }
        }
    }
    
    @IBAction func editResume(_ sender: Any) {
        performSegue(withIdentifier: "toEdit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            if let editVC = segue.destination as? EditController {
                editVC.resume = self.resume
            }
        }
    }
}
