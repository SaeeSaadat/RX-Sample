//
//  Combining Operators.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/19/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class CombiningOperators {
    public static func run(){
        
        //MARK: StartWith
        // basically takes an observable sequence and concatenates stuff to the beginning of it!
        example(of: "StartWith"){
            let disposeBag = DisposeBag()
            
            let prequelEpisodes = Observable.of(episodeI, episodeII, episodeIII)
            
            let flashback = prequelEpisodes.startWith(episodeIV, episodeV)
            
            flashback
                .subscribe(onNext: { episode in
                    print(episode)
                })
                .disposed(by: disposeBag)
        }
        
        //MARK: concat
        //Observable.concat(a,b)
        //a.concat(b)
        
        example(of: "Concat") {
            let disposeBag = DisposeBag()
            
            let prequelEpisodes = Observable.of(episodeI, episodeII, episodeIII)
            let originalTrilogy = Observable.of(episodeIV, episodeV, episodeVI)
            
            prequelEpisodes.concat(originalTrilogy)
                .subscribe(onNext: {
                    print($0)
                }).disposed(by: disposeBag)
        }
        
        //MARK: Merge
        // merges two observables (the order is based on the time the elements are emitted)
        example(of: "Merge"){
            let disposeBag = DisposeBag()
            
            let filmTrilogies = PublishSubject<String>()
            let standaloneFilms = PublishSubject<String>()
            let storyOrder = Observable.of(filmTrilogies, standaloneFilms)
            
            storyOrder.merge() //without merge, it would be observing just the Observables themeselves!!!
                .subscribe(onNext: {
                    print($0)
                }).disposed(by: disposeBag)
            
            filmTrilogies.onNext(episodeI)
            filmTrilogies.onNext(episodeII)
            
            standaloneFilms.onNext(solo)
            standaloneFilms.onNext(rogueOne)
            
            filmTrilogies.onNext(episodeIV )
        }
        
        //MARK: CombineLatest
        // it will combine the last elements emitted from each observable
        example(of: "combineLatest"){
            let disposeBag = DisposeBag()
            
            let characters = Observable.of("Luke", "Han Solo", "Leia", "Chewbacca")
            let primaryWeapons = Observable.of("Lightsaber" , "dl44", "defender", "bowcaster")
            let numbers = Observable.of(1 , 2 , 3, 4, 5 , 6 ,7 ,8)
            
            Observable.combineLatest(numbers, characters, primaryWeapons) {number, character, weapon in
                return "\(number)) \(character): \(weapon)"
            }
            .subscribe(onNext: {
                print($0)
                }).disposed(by: disposeBag)
        }
        
        //MARK: Zip
        //it will wait until all parts have emitted a new element, and then combines them
        example(of: "zip"){
            let disposeBag = DisposeBag()
            
            let characters = Observable.of("Luke", "Han Solo", "Leia", "Chewbacca")
            let primaryWeapons = Observable.of("Lightsaber" , "dl44", "defender", "bowcaster")
            let numbers = Observable.of(1 , 2 , 3, 4, 5 , 6 ,7 ,8)
            
            Observable.zip(numbers, characters, primaryWeapons) {number, character, weapon in
                return "\(number)) \(character): \(weapon)"
            }
            .subscribe(onNext: {
                print($0)
                }).disposed(by: disposeBag)
            
            let a = PublishSubject<Int>()
            let b = PublishSubject<String>()
            
            Observable.zip(a , b).subscribe{
                print($0)
            }.disposed(by: disposeBag)
            
            a.onNext(1)
            b.onNext("One")
            a.onNext(2)
            a.onNext(3)
            a.onNext(4)
            b.onNext("Two")
        }
        
        //MARK: SwitchLatest
        //like flatMapLatest, except it won't flatMap !
        //basically it will unsubscribe from the previous obsevable when another one emmits !
        //not that useful ! flatmap is more useful !
        example(of: "SwitchLatest"){
            let disposeBag = DisposeBag()
            
            let a = PublishSubject<Int>()
            let b = PublishSubject<Int>()
            
            let c = PublishSubject<PublishSubject<Int>>()
            
            c.switchLatest().subscribe{
                print($0)
            }.disposed(by: disposeBag)
                
            c.onNext(a)
            a.onNext(1)
            a.onNext(2)
            c.onNext(b)
            a.onNext(3)
            b.onNext(11)
            b.onNext(22)
            a.onNext(4)
        }
        
        //MARK: amb
        //after the subscription is made, the one that emmits first will remain subscribed and the rest will lose their subscription !
        example(of: "amb"){
            let disposeBag = DisposeBag()
            
            let prequelEpisodes = PublishSubject<String>()
            let originalEpisodes = PublishSubject<String>()
            
            prequelEpisodes.amb(originalEpisodes)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
            originalEpisodes.onNext(episodeIV)
            
            prequelEpisodes.onNext(episodeI)
            prequelEpisodes.onNext(episodeII)
            
            originalEpisodes.onNext(episodeV)
        }
        
        //MARK: Reduce
        example(of: "reduce") {
            let disposeBag = DisposeBag()
            
            Observable.of(1, 2, 3, 4, 5)
                .reduce(0) { a , b in
                    return a+(b*2)
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        //MARK: Scan
        //reduce, but it will emmit each time the accumulation is done !
        example(of: "scan") {
            let disposeBag = DisposeBag()
            
            Observable.of(1, 2, 3, 4, 5)
                .scan(0) { a , b in
                    return a+(b*2)
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        //MARK: Challenge
        example(of: "scan+zip"){
            let disposeBag = DisposeBag()
            
            let titles = Observable.of("deadpool 1", "deadpool 2", "deadpool 3")
            let runTimes = Observable.of(1 , 2 , 3)
            let totalTime = runTimes.scan(0){ a, b in
                return a+b
            }
            
            Observable.zip(titles, runTimes, totalTime) { title, runTime, totalTime in
                    "\(title): \(runTime) => \(totalTime)"
                }
                .subscribe(onNext:{
                    print($0)
                })
                .disposed(by: disposeBag)
        }
    }
}
