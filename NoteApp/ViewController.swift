//
//  ViewController.swift
//  NoteApp
//
//  Created by Rezk on 13/02/2023.
//

import UIKit
import CoreData




class ViewController: UIViewController {
    var selectedNote : Note? = nil

    @IBOutlet weak var titleTf: UITextField!
    
    
    @IBOutlet weak var desTf: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(selectedNote != nil){
            
            titleTf.text = selectedNote?.title
            desTf.text = selectedNote?.desc
        }
        
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedNote == nil){
            
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTf.text
            newNote.desc = desTf.text
            
            do {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("context save error")
                
            }
        }else{
            let request : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do{
                let result : NSArray = try context.fetch(request) as NSArray
                for item in result {
                    
                    let note = item as! Note
                    if(note == selectedNote){
                        note.title = titleTf.text
                        note.desc = desTf.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
               }
           }
            catch{
                print("Fetch Failed")
            }
        }
    }
    
    
    
}

