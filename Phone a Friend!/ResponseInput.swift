//
//  ResponseInput.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/17/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit
import CoreData

class ResponseInput: UIViewController {
    
    var questions: [Question] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var inputResponse: UITextField!
    
    var currentQuestion: String = ""
    
    @IBAction func saveResponse(_ sender: Any) {
        addNewResponse()
        performSegue(withIdentifier: "sgShowResponses", sender: nil)
    }
    
    func getData(){
        do {
            questions = try context.fetch(Question.fetchRequest())
        } catch {
            print("Couldn't fetch Data")
        }
    }
    
    func addNewResponse() {
            if (inputResponse.text != "") {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let newResponse = Response(context: context)
                var input = (inputResponse?.text)! + "#"
                getData()
                
                
                var questionIndex = 0
                for (index, question) in questions.enumerated() {
                    if(question.questionName == currentQuestion) {
                        questionIndex = index
                    }
                }
                
                var currentQuestionEntity = questions[questionIndex]
                
                if(currentQuestionEntity.responses?.responseName != nil) {
                    newResponse.responseName = (currentQuestionEntity.responses?.responseName)! + input
                } else {
                    newResponse.responseName = input
                }
    
                currentQuestionEntity.setValue(newResponse, forKey: "responses")
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                //(UIApplication.shared.delegate as! AppDelegate).saveContext()
                inputResponse.text = ""
                inputResponse.resignFirstResponder()
        }
    }
    
    //backToResponsePage
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgShowResponses") {
            let vc = segue.destination as! Specific_Question_Page
            vc.currentQuestion = currentQuestion
        }
    }
    
    func textFieldShouldReturn(inputResponse: UITextField) -> Bool {
        inputResponse.resignFirstResponder()
        self.view.endEditing(true)
        return true
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
