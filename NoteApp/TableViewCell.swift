//
//  TableViewCell.swift
//  NoteApp
//
//  Created by Rezk on 13/02/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var noteTitle: UILabel!
    
    
    @IBOutlet weak var noteDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
 
}
