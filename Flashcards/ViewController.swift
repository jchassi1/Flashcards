//
//  ViewController.swift
//  Flashcards
//
//  Created by Justin Chassin on 10/13/18.
//  Copyright © 2018 Justin Chassin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashCardsController=self
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden){
            frontLabel.isHidden=false
        } else {
        frontLabel.isHidden=true
    }
    }
    
    func updateFlashcard(question: String, answer: String){
        frontLabel.text=question
        backLabel.text=answer
    }
    
    
}

