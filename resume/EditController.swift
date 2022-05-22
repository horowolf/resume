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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageName = resume?.photoName {
            photoView.image = UIImage(named: imageName)
        } else {
            photoView.image = UIImage(named: "noimage_png")
        }
        
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        self.present(controller, animated: true)
        controller.delegate = self
    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {}
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
