//
//  TableViewController.swift
//  NoteApp
//
//  Created by Rezk on 13/02/2023.
//

import UIKit
import CoreData

var noteList = [Note]()

class TableViewController: UITableViewController {
    
    var firstLoad = true
    
    func nonDeletedNotes() -> [Note]{
        
        var nonDeleteNoteList = [Note]()
        for item in noteList{
            if(item.deletedDate == nil)
            {
                nonDeleteNoteList.append(item)
            }
        }
        return nonDeleteNoteList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(firstLoad){
            
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do{
                let result : NSArray = try context.fetch(request) as NSArray
                for item in result {
                    
                    let note = item as! Note
                    noteList.append(note)
                
                    
                }
                
                
            }
            catch{
                print("Fetch Failed")
            }
            
        }

    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let thisNote : Note!
        
        thisNote = noteList[indexPath.row]
        
        cell.noteTitle.text = thisNote.title
        cell.noteDescription.text = thisNote.desc
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editNote") {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let noteDetail = segue.destination as? ViewController
            
            let selectedNote : Note!
            selectedNote = noteList[indexPath.row]
            noteDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let selectedNote : Note!
            selectedNote = noteList[indexPath.row]
            
            context.delete(selectedNote)
            noteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
