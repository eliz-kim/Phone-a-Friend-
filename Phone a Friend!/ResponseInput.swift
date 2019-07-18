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
    
    @IBOutlet weak var inputResponse: UITextField!
    
    @IBAction func saveResponse(_ sender: Any) {
        addNewResponse()
    }
    
    func addNewResponse() {
            if (inputResponse.text != "") {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let newResponse = Response(context: context)
                newResponse.responseName = inputResponse?.text
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                print(newResponse.responseName!)
                inputResponse.text = ""
                inputResponse.resignFirstResponder()
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
