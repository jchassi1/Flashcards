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
    var buttonPressed=""
    
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
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if (self.frontLabel.isHidden){
                self.frontLabel.isHidden=false
            } else {
                self.frontLabel.isHidden=true
            }
        })
        
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.2, animations: {
            if (self.buttonPressed=="next"){
                self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            }
            if (self.buttonPressed=="prev") {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            }
            
            
        }, completion: { finished in
            self.updateLabels()
            
            //for running other animation
            self.animateCardIn()
    
    })
    }
    
    func animateCardIn(){
        if (self.buttonPressed=="next"){
        //starts transformation on the right side
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }
        //starts transformation on left side (if prev button is instead selected)
        if (self.buttonPressed=="prev"){
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        }
        
        //animates card by going back to original location
        UIView.animate(withDuration: 0.2){
            self.card.transform = CGAffineTransform.identity
        }
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //updating index
        currentIndex+=1
        buttonPressed = "next"
        
        //updating labels according to index
       // updateLabels()
        
        //updating next+prev button functionality
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex-=1
        buttonPressed="prev"
        
        //updating Labels according to index
        // updateLabels()
        
        //updating next/prev buttons
        updateNextPrevButtons()
        
        animateCardOut()
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
        
        saveAllFlashcardstoDisk()
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
        print("read saved flashcards")
        }
    }
        
        

    
    


