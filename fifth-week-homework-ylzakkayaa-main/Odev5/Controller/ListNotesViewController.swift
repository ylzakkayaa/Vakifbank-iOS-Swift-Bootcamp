//
//  NotesViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 28.11.2022.
//

import UIKit

final class ListNotesViewController: UIViewController {
    
    @IBOutlet weak private var addNotesButtonOutlet: UIButton!
    @IBOutlet weak private var notesListTableView: UITableView!
    
    var notes: [Note] = []
    var selectedNote: Note?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = CoreDataManager.shared.getNotes()
        configureTableView()
        
        //Float button tanımlarını yaptım.
        addNotesButtonOutlet.setTitle("Add", for: .normal)
        addNotesButtonOutlet.layer.cornerRadius = 30
        addNotesButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        addNotesButtonOutlet.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addNotesButtonOutlet.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addNotesButtonOutlet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addNotesButtonOutlet.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    private func configureTableView() {
        notesListTableView.delegate = self
        notesListTableView.dataSource = self
        notesListTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        notesListTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    @IBAction private func addNotesButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toAddNote", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNote" {
            let destinationVC = segue.destination as! AddNotesViewController
            if selectedNote != nil {
                destinationVC.selectedNote = selectedNote
            }
            destinationVC.delegate = self
        }
    }
        
}

extension ListNotesViewController: NewNoteDelegate {
    func updatePressed(previousText: String, currentText: String, season: String, episode: String) {
        CoreDataManager.shared.updateNote(previousText: previousText, currentText: currentText, season: season, episode: episode) //Core dataya textin önceki ve şu anki halini gönderiyorum.
        notesListTableView.reloadData()
    }
    
    func savePressed(input: String, season: String, episode: String) {
        notes.append(CoreDataManager.shared.saveNote(text: input, season: season, episode: episode)!)
        notesListTableView.reloadData()
    }
}

extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(model: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "toAddNote", sender: nil)
        selectedNote = nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            CoreDataManager.shared.deleteNote(note: note)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


