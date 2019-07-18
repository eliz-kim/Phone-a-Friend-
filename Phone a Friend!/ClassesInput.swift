//
//  ClassesInput.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/18/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit

class ClassesInput: UIViewController {
    
    var subjectNumber: Int = 0
    
    struct Class {
        let Title: String?
        let Announcements: String?
    }
    
    var currentClass: Class?
    
    var classesArray: [Class] = [
        Class(Title: "Math",
              Announcements: "Etc"),
        Class(Title: "English",
              Announcements: "Etc"),
        Class(Title: "History",
              Announcements: "Etc"),
        Class(Title: "Science",
              Announcements: "Etc"),
        Class(Title: "Language",
              Announcements: "Etc"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    

    
    @IBAction func subjectPressed(_ sender: Any) {
        var button = sender as! UIButton
        
        subjectNumber = button.tag
        performSegue(withIdentifier: "sgShowSubject", sender: nil)
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SubjectInput
        vc.subjectNumber = subjectNumber
        
    }*/
    
}
