//
//  EditController.swift
//  resume
//
//  Created by horo on 5/22/22.
//

import UIKit

class EditController: UIViewController {
    var resume: ResumeModel?
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var objectiveTextView: UITextView!
    @IBOutlet weak var yearOfExpTextField: UITextField!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var skillButton: UIButton!
    @IBOutlet weak var educationButton: UIButton!
    @IBOutlet weak var projectButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageName = resume?.photoName {
            photoView.image = UIImage(named: imageName)
        } else {
            photoView.image = UIImage(named: "noimage_png")
        }
        
        mobileTextField.addTarget(self, action: #selector(syncTextChanges), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(syncTextChanges), for: .editingDidEnd)
        addressTextField.addTarget(self, action: #selector(syncTextChanges), for: .editingDidEnd)
        objectiveTextView.delegate = self
        yearOfExpTextField.addTarget(self, action: #selector(syncTextChanges), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
    }
    
    func reloadView() {
        guard let resume = resume else {
            return
        }
        
        Task {
            if let loadedImage = await ImageSLHandler().loadFrom(resume.photoName) {
                photoView.image = loadedImage
            }
        }
        
        self.mobileTextField.text = resume.mobile
        self.emailTextField.text = resume.email
        self.addressTextField.text = resume.address
        self.objectiveTextView.text = resume.objective
        self.yearOfExpTextField.text = "\(resume.yearOfExperience)"
        self.workButton.setTitle("\(resume.workSummary.count) work record\(resume.workSummary.count > 1 ? "s" : "")", for: .normal)
        self.skillButton.setTitle("\(resume.skills.count) skill\(resume.skills.count > 1 ? "s" : "")", for: .normal)
        self.educationButton.setTitle("\(resume.education.count) education record\(resume.education.count > 1 ? "s" : "")", for: .normal)
        self.projectButton.setTitle("\(resume.projects.count) project\(resume.projects.count > 1 ? "s" : "")", for: .normal)
    }
    
    @objc
    func syncTextChanges() {
        resume?.mobile = mobileTextField.text ?? ""
        resume?.email = emailTextField.text ?? ""
        resume?.address = addressTextField.text ?? ""
        resume?.objective = objectiveTextView.text
        resume?.yearOfExperience = Int(yearOfExpTextField.text ?? "0") ?? 0
    }
    
    @IBAction func saveReusme(_ sender: Any) {
        if let resume = resume {
            Task {
                await ResumeSLHandler().save(resume)
            }
        }
    }
    
    @IBAction func backToResume(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        self.present(controller, animated: true)
        controller.delegate = self
    }
    
    
    @IBAction func addWork(_ sender: Any) {
        performSegue(withIdentifier: "toWorkSummary", sender: nil)
    }
    
    @IBAction func addSkill(_ sender: Any) {
        performSegue(withIdentifier: "toSkill", sender: nil)
    }
    
    @IBAction func addEducation(_ sender: Any) {
        performSegue(withIdentifier: "toEducation", sender: nil)
    }
    
    @IBAction func addProject(_ sender: Any) {
        performSegue(withIdentifier: "toProject", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
           let tableVC = navi.viewControllers.first as? DetailTableViewController,
           let resume = resume {
            tableVC.parentVC = self
            if segue.identifier == "toWorkSummary" {
                tableVC.tableType = .work
                tableVC.dataRow = resume.workSummary
            } else if segue.identifier == "toSkill" {
                tableVC.tableType = .skill
                tableVC.dataRow = resume.skills
            } else if segue.identifier == "toEducation" {
                tableVC.tableType = .education
                tableVC.dataRow = resume.education
            } else if segue.identifier == "toProject" {
                tableVC.tableType = .project
                tableVC.dataRow = resume.projects
            }
        }
    }
}

extension EditController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
           let imgURL = info[.imageURL] as? URL {
            
            self.photoView.image = image
            self.photoView.isHidden = false
            view.layoutIfNeeded()
            
            Task.detached {
                if await ImageSLHandler().saveTo(imgURL.lastPathComponent, with: image) {
                    await MainActor.run {
                        self.resume?.photoName = imgURL.lastPathComponent
                    }
                }
            }
        }
        else {
            let controller = UIAlertController(title: "Failed", message: "Can not fetch image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        syncTextChanges()
    }
}
