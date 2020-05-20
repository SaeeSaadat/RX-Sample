//
//  ClockViewController.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/20/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import UIKit
import UIKit
import RxCocoa
import RxSwift

class ClockViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeBackGesture()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        
        Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .startWith(0)
            .map{ _ in
                return dateFormatter.string(from: Date())
            }
            .bind(to: clockLabel.rx.text)
            .disposed(by: disposeBag)
    }
    

    
    private func addSwipeBackGesture() {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = [.right]
        gesture.addTarget(self, action: #selector(goBack))
        self.view.addGestureRecognizer(gesture)
    }

    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
