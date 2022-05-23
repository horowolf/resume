//
//  DetailTableViewController.swift
//  resume
//
//  Created by horo on 5/23/22.
//

import UIKit

enum DetailSelector: String {
    case work = "Work experiences"
    case skill = "Skills"
    case education = "Education details"
    case project = "Project details"
}

class DetailTableViewController: UITableViewController {
    
    var tableType: DetailSelector = .work
    var dataRow: [Codable] = []
    weak var parentVC: EditController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = tableType.rawValue

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let editVC = parentVC {
            switch tableType {
            case .work:
                guard let work = dataRow as? [WorkSummary] else {
                    return
                }
                editVC.resume!.workSummary = work
            case .skill:
                guard let skill = dataRow as? [Skill] else {
                    return
                }
                editVC.resume!.skills = skill
            case .education:
                guard let education = dataRow as? [Education] else {
                    return
                }
                editVC.resume!.education = education
            case .project:
                guard let project = dataRow as? [Project] else {
                    return
                }
                editVC.resume!.projects = project
            }
            editVC.reloadView()
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        switch tableType {
        case .work:
            let item = WorkSummary(company: "New company", duration: "Current")
            dataRow.append(item)
            self.tableView.reloadData()
        case .skill:
            let item = Skill(skill: "New skill")
            dataRow.append(item)
            self.tableView.reloadData()
        case .education:
            let item = Education(school: "New school", passingYear: 1, CGPA: 1)
            dataRow.append(item)
            self.tableView.reloadData()
        case .project:
            let item = Project(name: "New project", teamSize: 1, summary: "New", usedTech: "Non", role: "Self")
            dataRow.append(item)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailEditing" {
            if let detailVC = segue.destination as? DetailViewController,
               let senderData = sender as? DetailVCInitHolder {
                detailVC.detailType = senderData.detailType
                detailVC.detailData = senderData.detailData
                detailVC.updateClosure = senderData.updateClosure
            }
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        if let editVC = unwindSegue.destination as? EditController {
            
        }
    }
}

extension DetailTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataRow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableType {
        case .work:
            guard let work = dataRow[indexPath.row] as? WorkSummary else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "Fail")
                cell.textLabel?.text = "No data"
                return cell
            }
            let cell = UITableViewCell(style: .default, reuseIdentifier: "work")
            cell.textLabel?.text = work.company
            return cell
            
        case .skill:
            guard let skill = dataRow[indexPath.row] as? Skill else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "Fail")
                cell.textLabel?.text = "No data"
                return cell
            }
            let cell = UITableViewCell(style: .default, reuseIdentifier: "skill")
            cell.textLabel?.text = skill.skill
            return cell
            
        case .education:
            guard let education = dataRow[indexPath.row] as? Education else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "Fail")
                cell.textLabel?.text = "No data"
                return cell
            }
            let cell = UITableViewCell(style: .default, reuseIdentifier: "education")
            cell.textLabel?.text = education.school
            return cell
        case .project:
            guard let project = dataRow[indexPath.row] as? Project else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "Fail")
                cell.textLabel?.text = "No data"
                return cell
            }
            let cell = UITableViewCell(style: .default, reuseIdentifier: "project")
            cell.textLabel?.text = project.name
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var closure: (Codable) -> () = { data in
            self.dataRow[indexPath.row] = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        var holder = DetailVCInitHolder()
        holder.detailType = self.tableType
        holder.detailData = dataRow[indexPath.row]
        holder.updateClosure = closure
        
        performSegue(withIdentifier: "toDetailEditing", sender: holder)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataRow.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
