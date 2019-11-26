//
//  ColorViewController.swift
//  NoteApp
//
//  Created by MAC on 24/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import IGColorPicker

class ColorViewController: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    public var main = MainViewController()
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var colorPickerView: ColorPickerView!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBAction func confirm(_ sender: Any) {
            main.changeColor(color: selectedColorView.backgroundColor!)
            navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Color"
        // Setup selectedColorView
        selectedColorView.layer.cornerRadius = selectedColorView.frame.width/2
        
        // Setup colorPickerView
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.style = .circle
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.preselectedIndex = colorPickerView.colors.indices.first
        colorPickerView.colors[0] = UIColor.white
        selectedColorView.backgroundColor = colorPickerView.colors.first
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
