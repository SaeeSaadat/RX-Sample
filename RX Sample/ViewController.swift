//
//  ViewController.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/12/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //add the following line in case it couldn't build at start :
        //_ = Observable.of("Salam GolaB!")
        
        addSwipeGesture()
        
    }


    private func addSwipeGesture() {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = [.left]
        gesture.addTarget(self, action: #selector(goToClock))
        self.view.addGestureRecognizer(gesture)
    }

    @objc private func goToClock() {
        if let vc = storyboard?.instantiateViewController(identifier: "ClockView"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func runExamples(){

                //MARK: Section 1
        //        ExampleZero.run()
        //        FirstExample.run()
        //        SecondExamples.run()
        //        Project1.run()
                
                //MARK: Section 2
        //        OperatorsExamples.run()
                
                //MARK: Section 3
        //        Transformers.run()
                
                //MARK: Section 4
        //        CombiningOperators.run()
        //        MoreCombining.run()
                
                //MARK: Section 5
        //        TimeBasedOperators.run(button: button)
        //        TimeOperatros.run()
    }
    
}

