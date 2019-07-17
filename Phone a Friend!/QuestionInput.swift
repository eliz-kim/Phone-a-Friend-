//
//  QuestionInput.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/17/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit
import CoreData

class QuestionInput: UIViewController {
    
    @IBOutlet weak var inputQuestion: UITextField!
    
    @IBAction func SaveQuestion(_ sender: Any) {
        addNewQuestion()
    }
    
    func addNewQuestion() {
        if (inputQuestion.text != "") {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newQuestion =  Question(context: context)
            newQuestion.questionName = inputQuestion?.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            inputQuestion.text = ""
            inputQuestion.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
