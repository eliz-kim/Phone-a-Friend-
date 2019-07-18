//
//  FeedReceiveInput.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/17/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//
import UIKit
import CoreData

class FeedReceiveInput: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var questions: [Question] = [] ////////QUESTION
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myQuestionTable {
            return self.questions.count
        }
        return 0
    } ////////////QUESTIONS
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myQuestionTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UITableViewCell
            cell!.textLabel?.text = self.questions[indexPath.row].questionName
            return cell!
        }
        
        return UITableViewCell()
    } /////////////QUESTIONS
    

    @IBOutlet weak var myQuestionTable: UITableView!
    
    func getData(){
        do {
            questions = try context.fetch(Question.fetchRequest())
            DispatchQueue.main.async {
                self.myQuestionTable.reloadData()
            }
        } catch {
            print("Couldn't fetch Data")
        }
    } //////////////QUESTION
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == myQuestionTable {
                let question = self.questions[indexPath.row]
                self.context.delete(question)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                self.questions.remove(at: indexPath.row)
                myQuestionTable.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgShowQuestionInfo", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        myQuestionTable.delegate = self as? UITableViewDelegate
        myQuestionTable.dataSource = self as? UITableViewDataSource
        self.myQuestionTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()///////QUESTION
   }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func myQuestionTable(myQuestionTable: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func myQuestionTable(myQuestionTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = self.myQuestionTable.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
//
//        cell.textLabel?.text = self.questions[indexPath.row].questionName
//
//        return cell
//    }
    
//    func myQuestionTable(myQuestionTable: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell #\(indexPath.row)!")
//    } /////////QUESTION
//
//    func myResponseTable(myResponseTable: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell #\(indexPath.row)!")
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
