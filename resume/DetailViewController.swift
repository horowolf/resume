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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    func updateDetail() {
        if let detail = detailData,
           let complete = updateClosure {
            complete(detail)
        }
    }
    
}

struct DetailVCInitHolder {
    var detailType: DetailSelector = .work
    var detailData: Codable?
    var updateClosure: ((Codable) -> ())?
}
