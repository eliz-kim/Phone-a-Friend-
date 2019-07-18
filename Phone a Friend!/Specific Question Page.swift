//
//  Specific Question Page.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/17/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit
import CoreData
import Foundation



class Specific_Question_Page: UIViewController , UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var response: Response?
    var responses: [String] = []
    var currentQuestion: String = ""
    var questions: [Question] = []
    var questionIndex: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == myResponseTable {
            return self.responses.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView == myResponseTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? UITableViewCell
            cell!.textLabel?.text = self.responses[indexPath.row]
            return cell!
        }
        return UITableViewCell()
    }
    
    @IBOutlet weak var myResponseTable: UITableView!
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
             if tableView == myResponseTable {
                var removedResponseArray: [String] = []
                var newResponse: String = ""
                for resp in responses {
                    if(resp != self.responses[indexPath.row]) {
                        removedResponseArray.append(resp)
                        newResponse = newResponse + resp + "#"
                    }
                }
                
                responses = removedResponseArray
                
                questions[questionIndex].responses?.responseName = newResponse
                
                print("Deleting")
                print(newResponse)
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                myResponseTable.deleteRows(at: [indexPath], with: .fade)

                /*self.context.delete(response)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                self.responses.remove(at: indexPath.row)
                myResponseTable.deleteRows(at: [indexPath], with: .fade)*/
            }
        }
    

    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgShowResponseInfo", sender: nil)
    }*/

    // sgInputResponse

    override func viewDidLoad() {
        super.viewDidLoad()
        myResponseTable.delegate = self as? UITableViewDelegate
        myResponseTable.dataSource = self as? UITableViewDataSource
        self.myResponseTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        if((response?.responseName) != nil) {
            responses = (response?.responseName?.components(separatedBy: "#"))!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgInputResponse") {
            let vc = segue.destination as! ResponseInput
            vc.currentQuestion = currentQuestion
        }
    }
    
    func getData(){
        do {
            questions = try context.fetch(Question.fetchRequest())
        } catch {
            print("Couldn't fetch Data")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getData()
        for (index, question) in questions.enumerated() {
            if(question.questionName == currentQuestion) {
                questionIndex = index
            }
        }
        
        response = questions[questionIndex].responses
        if((response?.responseName) != nil) {
            responses = (response?.responseName?.components(separatedBy: "#"))!
            DispatchQueue.main.async {
                self.myResponseTable.reloadData()
            }
        }
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
