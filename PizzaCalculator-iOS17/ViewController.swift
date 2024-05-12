//
//  ViewController.swift
//  PizzaCalculator-iOS17
//
//  Created by Mayur Vaity on 12/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var NumberOfPeople: UITextField!
    
    @IBOutlet weak var SizeOfPizza: UITextField!
    
    @IBOutlet weak var SlicesPerPerson: UITextField!
    
    @IBOutlet weak var NumberOfPizzasRequired: UILabel!
    
    //MARK: - Variables
    var numberOfPeople: Int = 0
    var slicesPerPerson: Int = 0
    
    var pizzaInInches: Int = 0 {
        //to validate size of pizza
        didSet {
            print(oldValue)
            print(pizzaInInches)
            if pizzaInInches > 18 || pizzaInInches < 8 {
                getFinalPizzaSize(pizzaSize: pizzaInInches)
                pizzaInInches = pizzaInInches < 8 ? 8 : 18
                SizeOfPizza.text = String(pizzaInInches)
            }
        }
    }
    
    var numberOfSlices: Int {
        return pizzaInInches - 4
    }
    
    //in below example, setter is used to calculate numberOfPeople required to finish specified # of pizzas
    var numberOfPizza: Int {
        get {
            let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
            return numberOfPeople / numberOfPeopleFedPerPizza
        }
        set {
            let totalSlices = numberOfSlices * newValue
            numberOfPeople = totalSlices / slicesPerPerson
        }
    }
    
    //MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NumberOfPizzasRequired.text = ""
        NumberOfPeople.text = "10"
        SizeOfPizza.text = "33"
        SlicesPerPerson.text = "4"
    }
    
    
    @IBAction func calculateNumberOfPizza(_ sender: UIButton) {
        //checking of fields are empty
        if NumberOfPeople.text != "" && SizeOfPizza.text != "" && SlicesPerPerson.text != "" {
            print("All fields available.")
            
            numberOfPeople = Int(NumberOfPeople.text!)!
            pizzaInInches = Int(SizeOfPizza.text!)!
            slicesPerPerson = Int(SlicesPerPerson.text!)!
            
            print("numberOfPizza = ", numberOfPizza)
            print("SizeOfPizza = ", pizzaInInches)
            NumberOfPizzasRequired.text = "Number of Pizzas required: \(numberOfPizza)"
        } else {
            print("Fill all the details")
        }
        
    }
    
    func getFinalPizzaSize(pizzaSize : Int) {
        let message = pizzaSize < 8 ? "Invalid pizza size, now set to 8." : "Invalid pizza size, now set to 18."
        
        let alertController = UIAlertController(title: "Invalid Pizza Size", message: message, preferredStyle: .alert)
        
        let proceedAction = UIAlertAction(title: "Proceed", style: .default) { action in
            print("proceeding...")
        }
        
        alertController.addAction(proceedAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}

