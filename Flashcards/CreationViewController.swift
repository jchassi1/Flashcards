//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Justin Chassin on 10/27/18.
//  Copyright © 2018 Justin Chassin. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashCardsController: ViewController!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
       let questionText = questionField.text
       let answerText = answerField.text
        flashCardsController.updateFlashcard(question: questionText!, answer: answerText!)
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
