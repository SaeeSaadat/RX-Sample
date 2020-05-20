//
//  TimeOperatros.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/20/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class TimeOperatros {
    public static func run(){
        
        //MARK: Interval
//        let sourceObservable = Observable<Int>
//            .interval(.seconds(5), scheduler: MainScheduler.instance)
//            .replay(5)
        // every 5 seconds, it emits something with a count!(0, 1, 2,...)
        //there's an example of it in the clockView (RxCocoa)
        
        //MARK: timer
//        _ = Observable<Int>.timer(3, scheduler: MainScheduler.instance)
            //.flatMap { _ in
                //...
            //}.subscribe{...}
                
        //just like interval but with a due date !
        
        
        //MARK: Timeout
        // button.rx.tap.map{ _ in "." }
        //  .timeout(5, scheduler: MainScheduler.instance).subscribe...
        
        //if it doesn't recieve anything after 5 seconds it'll emit an error!
        
        
    }
}
