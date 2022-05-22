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
    var resume = ResumeSLHandler().getDefaultValue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.isScrollEnabled = true
        image.image = UIImage(named: "noimage_png")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            if let resumeData = await ResumeSLHandler().load() {
                resume = resumeData
                if let loadedImage = await ImageSLHandler().loadFrom(resume.photoName) {
                    image.image = loadedImage
                }
                // TODO: Other data
                
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
