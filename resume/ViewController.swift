//
//  ViewController.swift
//  resume
//
//  Created by horo on 5/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image.image = UIImage(named: "noimage_png")
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        self.present(controller, animated: true)
        controller.delegate = self
    }
    
    @IBAction func loadImage(_ sender: Any) {
        Task.detached {
            let load = await ImageSLHandler().loadFrom("a.png")
            if let img = load {
                await MainActor.run {
                    self.image.image = img
                }
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            view.layoutIfNeeded()
            self.image.image = image
            self.image.isHidden = false
            
            Task.detached {
                await ImageSLHandler().saveTo("a.png", with: image)
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
