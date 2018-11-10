//
//  ViewController.swift
//  Flashcards
//
//  Created by Justin Chassin on 10/13/18.
//  Copyright © 2018 Justin Chassin. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readSavedFlashcards()
        
        if flashcards.count==0{
            updateFlashcard(question: "What is the capital of Peru?", answer: "Lima")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //updating index
        currentIndex+=1
        
        //updating labels according to index
        updateLabels()
        
        //updating next+prev button functionality
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex-=1
        
        //updating Labels according to index
        updateLabels()
        
        //updating next/prev buttons
        updateNextPrevButtons()
    }
    
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //Updating current index
        currentIndex = flashcards.count-1
        print("We are at index \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled=false
        } else {
            nextButton.isEnabled=true
        }
        
        if currentIndex==0{
            prevButton.isEnabled=false
        } else {
            prevButton.isEnabled=true
        }
    }
    
    func saveAllFlashcardstoDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question":card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
        }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question:dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
            }
        }
    }
        
        

    
    


