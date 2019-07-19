//
//  SubjectInput.swift
//  Phone a Friend!
//
//  Created by Girls Who Code on 7/18/19.
//  Copyright © 2019 Girls Who Code. All rights reserved.
//

import UIKit

class SubjectInput: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subjectImage: UIImageView!
    var subjectNumber: Int = 0
    var subjects: [String] = ["MATH", "ENGLISH", "HISTORY", "SCIENCE", "LANGUAGE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(subjectNumber)
        titleLabel.text = subjects[subjectNumber]
        subjectImage.image = UIImage(named: subjects[subjectNumber])
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
