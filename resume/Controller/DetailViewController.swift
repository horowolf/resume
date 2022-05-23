//
//  DetailViewController.swift
//  resume
//
//  Created by horo on 5/23/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailType: DetailSelector = .work
    var detailData: Codable?
    var updateClosure: ((Codable) -> ())?
    
    let companyTextField = UITextField()
    let durationTextField = UITextField()
    let skillTextField = UITextField()
    let schoolTextField = UITextField()
    let passingYearTextField = UITextField()
    let CGPATextField = UITextField()
    let projectNameTextField = UITextField()
    let teamsizeTextField = UITextField()
    let usedTechTextField = UITextField()
    let roleTextField = UITextField()
    let summaryTextView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        switch detailType {
        case .work:
            companyTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            companyTextField.placeholder = "Company name"
            companyTextField.backgroundColor = .lightGray
            
            durationTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            durationTextField.placeholder = "Duration"
            durationTextField.backgroundColor = .lightGray
            
            if let work = detailData as? WorkSummary {
                companyTextField.text = work.company
                durationTextField.text = work.duration
            }
            
            self.view.addSubview(companyTextField)
            self.view.addSubview(durationTextField)
            
            companyTextField.translatesAutoresizingMaskIntoConstraints = false
            durationTextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: companyTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: durationTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: companyTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: durationTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: durationTextField, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: durationTextField, attribute: .top, relatedBy: .equal, toItem: companyTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0)
            ])
            
            
        case .skill:
            skillTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            skillTextField.placeholder = "Skill name"
            skillTextField.backgroundColor = .lightGray
            
            if let skill = detailData as? Skill {
                skillTextField.text = skill.skill
            }
            
            self.view.addSubview(skillTextField)
            
            skillTextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: skillTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: skillTextField, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: skillTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0)
            ])
            
        case .education:
            schoolTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            schoolTextField.placeholder = "School name"
            schoolTextField.backgroundColor = .lightGray
            
            passingYearTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            passingYearTextField.placeholder = "Passing year"
            passingYearTextField.backgroundColor = .lightGray
            
            CGPATextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            CGPATextField.placeholder = "CGPA"
            CGPATextField.backgroundColor = .lightGray
            
            if let education = detailData as? Education {
                schoolTextField.text = education.school
                passingYearTextField.text = "\(education.passingYear)"
                CGPATextField.text = "\(education.CGPA)"
            }
            
            self.view.addSubview(schoolTextField)
            self.view.addSubview(passingYearTextField)
            self.view.addSubview(CGPATextField)
            
            schoolTextField.translatesAutoresizingMaskIntoConstraints = false
            passingYearTextField.translatesAutoresizingMaskIntoConstraints = false
            CGPATextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: schoolTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: passingYearTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0),
                NSLayoutConstraint.init(item: CGPATextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
                NSLayoutConstraint.init(item: schoolTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: passingYearTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: CGPATextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: CGPATextField, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: CGPATextField, attribute: .top, relatedBy: .equal, toItem: passingYearTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
                NSLayoutConstraint.init(item: passingYearTextField, attribute: .top, relatedBy: .equal, toItem: schoolTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0)
            ])
            
        case .project:
            projectNameTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            projectNameTextField.placeholder = "Project name"
            projectNameTextField.backgroundColor = .lightGray
            
            teamsizeTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            teamsizeTextField.placeholder = "Team size"
            teamsizeTextField.backgroundColor = .lightGray
            
            usedTechTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            usedTechTextField.placeholder = "Technology used"
            usedTechTextField.backgroundColor = .lightGray
            
            roleTextField.addTarget(self, action: #selector(updateDetail), for: .editingDidEnd)
            roleTextField.placeholder = "Role"
            roleTextField.backgroundColor = .lightGray
            
            summaryTextView.delegate = self
            summaryTextView.backgroundColor = .lightGray
            
            if let project = detailData as? Project {
                projectNameTextField.text = project.name
                teamsizeTextField.text = "\(project.teamSize)"
                usedTechTextField.text = project.usedTech
                roleTextField.text = project.role
                summaryTextView.text = project.summary
            }
            
            self.view.addSubview(projectNameTextField)
            self.view.addSubview(teamsizeTextField)
            self.view.addSubview(usedTechTextField)
            self.view.addSubview(roleTextField)
            self.view.addSubview(summaryTextView)
            
            projectNameTextField.translatesAutoresizingMaskIntoConstraints = false
            teamsizeTextField.translatesAutoresizingMaskIntoConstraints = false
            usedTechTextField.translatesAutoresizingMaskIntoConstraints = false
            roleTextField.translatesAutoresizingMaskIntoConstraints = false
            summaryTextView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: projectNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: teamsizeTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0),
                NSLayoutConstraint.init(item: usedTechTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: roleTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0),
                NSLayoutConstraint.init(item: summaryTextView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0),
                NSLayoutConstraint.init(item: projectNameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: teamsizeTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: usedTechTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: roleTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: summaryTextView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: roleTextField, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint.init(item: roleTextField, attribute: .top, relatedBy: .equal, toItem: usedTechTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
                NSLayoutConstraint.init(item: usedTechTextField, attribute: .top, relatedBy: .equal, toItem: teamsizeTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
                NSLayoutConstraint.init(item: teamsizeTextField, attribute: .top, relatedBy: .equal, toItem: projectNameTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
                NSLayoutConstraint.init(item: summaryTextView, attribute: .top, relatedBy: .equal, toItem: roleTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0),
                NSLayoutConstraint.init(item: summaryTextView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.3, constant: 0.0)
            ])
        }
    }
    
    @objc
    func updateDetail() {
        switch detailType {
        case .work:
            if var detail = detailData as? WorkSummary,
               let complete = updateClosure {
                detail.company = companyTextField.text ?? ""
                detail.duration = durationTextField.text ?? ""
                complete(detail)
            }
        case .skill:
            if var detail = detailData as? Skill,
               let complete = updateClosure {
                detail.skill = skillTextField.text ?? ""
                complete(detail)
            }
        case .education:
            if var detail = detailData as? Education,
               let complete = updateClosure {
                detail.school = schoolTextField.text ?? ""
                detail.passingYear = Int(passingYearTextField.text ?? "0") ?? 0
                detail.CGPA = Double(CGPATextField.text ?? "0.0") ?? 0.0
                complete(detail)
            }
        case .project:
            if var detail = detailData as? Project,
               let complete = updateClosure {
                detail.name = projectNameTextField.text ?? ""
                detail.teamSize = Int(teamsizeTextField.text ?? "1") ?? 1
                detail.usedTech = usedTechTextField.text ?? ""
                detail.role = roleTextField.text ?? ""
                detail.summary = summaryTextView.text
                complete(detail)
            }
        }
        
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateDetail()
    }
}


struct DetailVCInitHolder {
    var detailType: DetailSelector = .work
    var detailData: Codable?
    var updateClosure: ((Codable) -> ())?
}
