//
//  ViewController.swift
//  TestTwo
//
//  Created by MICHELLE M KOETH on 12/28/20.
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet weak var textLabel:UILabel?
    @IBOutlet weak var servoControl:UISegmentedControl!
    @IBOutlet weak var stepperDirection:UISegmentedControl!
    @IBOutlet weak var stepperSteps:UISegmentedControl!
    @IBOutlet weak var stepperGoButton:UIButton!
    
    //By default the stepper motor will move clockwise which is reverse direction
    var stepperDirectionString = "REV"
    var stepperDefaultSteps = 160
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getCall()
    }
    
   //@IBAction func onSliderMove(sender: UISlider){
   //     let slider: UISlider = sender
   //     let stepval = slider.value
   //     let slidervalint = Int(stepval)
   //     let dirval = "FWD"
   //     getStepper(steps: slidervalint, direction: dirval)
   //}
    
    /* @IBAction func onStepperTextEntry(sender: UITextField){
        let tf: UITextField = sender
        let stepval = tf.text!
        print("Step val is: " + stepval)
        //let slidervalint = Int(stepval)!
        let dirval = "FWD"
        getStepper(steps: stepval, direction: dirval)
    }
    */
    
    /* This function will be called when user press the first UISegmentedControl object. */
    @IBAction func pressSegmentDirection(_ sender: UISegmentedControl) {
        // Get user selected UISegmentedControl item index.
        let selIdx:Int = sender.selectedSegmentIndex
        // Get selected item title or image.
        let selSegTitle: String! = sender.titleForSegment(at: selIdx)
        //let degreeamount = Int(selSegTitle)
        if (stepperDirectionString != selSegTitle) {
            stepperDirectionString = selSegTitle
        }
    }
    
    @IBAction func pressSegmentSteps(_ sender: UISegmentedControl) {
        // Get user selected UISegmentedControl item index.
        let selIdx:Int = sender.selectedSegmentIndex
        // Get selected item title or image.
        let selSegTitle: String! = sender.titleForSegment(at: selIdx)
        //let degreeamount = Int(selSegTitle)
        if (String(stepperDefaultSteps) != selSegTitle) {
            stepperDirectionString = selSegTitle
        }
    }
    
    
    
    /* This function will be called when user press the first UISegmentedControl object. */
    @IBAction func pressSegmentOne(_ sender: UISegmentedControl) {
        // Get user selected UISegmentedControl item index.
        let selIdx:Int = sender.selectedSegmentIndex
        // Get selected item title or image.
        let selSegTitle: String! = sender.titleForSegment(at: selIdx)
        let degreeamount = Int(selSegTitle)
        getCall(degree: degreeamount!)
    }
    
   @IBAction func onPressStepperGoButton(sender:UIButton!) {
        //let btn: UIButton = sender
        //let degreeamount = btn.tag
        // Get the desired stepper motor direction
        let selIdx:Int = stepperDirection.selectedSegmentIndex
        let selSegTitle: String! = stepperDirection.titleForSegment(at: selIdx)
        // Get the desired stepper step amount
        let selIdxAmt:Int = stepperSteps.selectedSegmentIndex
        let selSegAmt: String! = stepperSteps.titleForSegment(at: selIdxAmt)
        getStepper(steps: selSegAmt, direction: selSegTitle)
    }
    


    // code for a get call
    func getStepper(steps: String, direction: String) {
        //let stepsstr = String(steps)
        var stepperDir = "REV"
        if direction == "CCW" { stepperDir = "FWD"}
        let url = URL(string: "http://192.168.101.177/setSTEPPER?dir="+stepperDir+"&stepno="+steps)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
           // if let response = response {
           //     print(response)
            //}
            do {
                // turn data into json object
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    json.forEach({ element in
                        if let body = element["status"] as? String {
                            print(body)
                        }
                    })
                }
                    
            } //catch { }
                
        }.resume()
    }
    // code for a get call
    func getCall(degree: Int) {
        let degreestr = String(degree)
        let url = URL(string: "http://192.168.101.177/setPOS?servoPOS=" + degreestr)!
        print("calling the servo ")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
           // if let response = response {
           //     print(response)
            //}
            do {
                // turn data into json object
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    json.forEach({ element in
                        if let body = element["status"] as? String {
                            print(body)
                        }
                    })
                }
                    
            } //catch { }
                
        }.resume()
    }

}

