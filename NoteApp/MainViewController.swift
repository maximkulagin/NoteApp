//
//  MainViewController.swift
//  NoteApp
//
//  Created by MAC on 24/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    public var existingNote: Note?
    public var existingNoteIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        if existingNote == nil{
            title = "New note"
        }
        else{
            title = "Note"
            titleView.text = existingNote!.title
            textView.text = existingNote!.content
            colorView.backgroundColor = existingNote!.color
            if let date = existingNote!.selfDestructionDate{
                switcher.setOn(true, animated: true)
                calendar.setDate(date, animated: true)
                calendar.isHidden = false
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save(_:)))
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var calendar: UIDatePicker!
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var colorView: UIView!
    public func changeColor(color: UIColor){
        colorView.backgroundColor = color
    }
    @objc @IBAction func save(_ sender: Any){
        if let noteTitle = titleView.text, let noteText = textView.text, noteText != "", noteTitle != ""{
            if let index = existingNoteIndex{
                notebook.remove(index: index)
            }
            let noteColor = colorView.backgroundColor!
            if(switcher.isOn){
               let note = Note(title: noteTitle, content: noteText, color: noteColor, importance: Note.Importance.usual, selfDestructionDate: calendar.date)
                notebook.add(note: note)
            }
            else{
                let note = Note(title: noteTitle, content: noteText, color: noteColor, importance: Note.Importance.usual)
                notebook.add(note: note)
            }
            navigationController?.popViewController(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please, enter title and text of the note", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func colorButtonPressed(_ sender: Any) {
        let colorViewController = ColorViewController()
        colorViewController.main = self
        colorViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(colorViewController, animated: true)
    }
    @IBAction func switcherChanged(_ sender: Any) {
        if switcher.isOn{
            calendar.isHidden = false
        }
        else {
            calendar.isHidden = true
        }
    }

}
