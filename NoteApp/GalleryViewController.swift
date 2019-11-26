//
//  GalleryViewController.swift
//  HelloUserName
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    public var img_index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(del(_:)))
        let img = photobook.get_photos()[img_index]
        imageView.image = img
        // Do any additional setup after loading the view.
    }

    @objc @IBAction func del(_ sender: Any){
        photobook.delete(at: img_index)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
