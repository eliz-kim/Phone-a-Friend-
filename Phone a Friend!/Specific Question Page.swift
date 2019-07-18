//
//  Specific Question Page.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/17/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit
import CoreData



class Specific_Question_Page: UIViewController , UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var responses: [Response] = [] ////////RESPONSE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == myResponseTable {
            return self.responses.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView == myResponseTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? UITableViewCell
            cell!.textLabel?.text = self.responses[indexPath.row].responseName
            return cell!
        }
        return UITableViewCell()
    }
    
    @IBOutlet weak var myResponseTable: UITableView!
    
    func getResponseData(){
        do {
            responses = try context.fetch(Response.fetchRequest())
            DispatchQueue.main.async {
                self.myResponseTable.reloadData()
            }
        } catch {
            print("Couldn't fetch Data")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
             if tableView == myResponseTable {
                let response = self.responses[indexPath.row]
                self.context.delete(response)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                self.responses.remove(at: indexPath.row)
                myResponseTable.deleteRows(at: [indexPath], with: .fade)
            }
        }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgShowResponseInfo", sender: nil)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        getResponseData()
        myResponseTable.delegate = self as? UITableViewDelegate
        myResponseTable.dataSource = self as? UITableViewDataSource
        self.myResponseTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        getResponseData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
