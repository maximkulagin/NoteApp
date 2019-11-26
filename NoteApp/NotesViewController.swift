//
//  NotesViewController.swift
//  NoteApp
//
//  Created by MAC on 24/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.get_notes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let note = notebook.get_at(at: indexPath.row)
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content
        cell.backgroundColor = note.color
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(new(_:)))
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    @objc @IBAction func edit(_ sender: Any){
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit(_:)))
        }
        else if notebook.get_notes().count != 0{
            tableView.setEditing(true, animated: true)
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(edit(_:)))
        }
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        notebook.remove(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = notebook.get_at(at: indexPath.row)
        let mainViewController = MainViewController()
        mainViewController.existingNote = note
        mainViewController.existingNoteIndex = indexPath.row
        mainViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    @objc @IBAction func new(_ sender: Any){
        let mainViewController = MainViewController()
        mainViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
