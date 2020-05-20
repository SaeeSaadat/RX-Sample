//
//  FirstExamples.swift
//  RX Sample
//
//  Created by Saee Saadat on 5/13/20.
//  Copyright © 2020 Saee Saadat. All rights reserved.
//

import Foundation
import RxSwift

class FirstExample {
    static func run() {
        
        example(of: "Creating observables"){
            //MARK: creating Observables
            let _: Observable<String> = Observable<String>.just(episodeV)
            let _ = Observable.of(episodeIV , episodeV, episodeVI)
            let _ = Observable.of([episodeI , episodeII, episodeIII]) //NO
            let sequalTrilogy = Observable.from([episodeVII , episodeVIII, episodeIX])
            
            
            
            sequalTrilogy.subscribe{ event in
                print(event.element ?? event)
            }.dispose()
        }
        
        //MARK: Never
        example(of: "never") {
            //just doesn't emmit anything ! useful for neverending stuff !
            
            let disposeBag = DisposeBag()
            
            let observable = Observable<Any>.never()
            
            observable.do(onNext: { element in
                print("do onNext" , element)
            }, afterNext: { element in
                print("do afterNext" , element)
            }, onCompleted: {
                print("do completed")
            }, onSubscribe: {
                print("do onSubscribe")
            }, onSubscribed: {
                print("do onSubscribed")
            }, onDispose: {
                print("do onDispose") // this is the only one that works !
            }).subscribe(onNext: {element in
                print(element)
            } , onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)
        }
        
        
        //Mark: Dispose
        example(of: "Dispose"){
            let mostPopular = Observable.of(episodeV , episodeIV , episodeVI)
            let subscription = mostPopular.subscribe{ event in
                print(event)
            }
            subscription.dispose() // cancel subscription
        }
        
        //MARK: Dispose Bag
        // basically we add all of our disposables (the subscriptions) to the disposeBag and in the "deinit" function inside our viewController , it will be called ! instead of having to deallocate all the disposables manually our selves !
        example(of: "Dispose Bag"){
            let disposeBag = DisposeBag()
            Observable.of(episodeVII , episodeI , rogueOne).subscribe{
                print($0)
            }.disposed(by: disposeBag)
            
        }
        
        
        //MARK: Create
        example(of: "Complete"){
            enum Droid : Error{
                case OU812
            }
            
            let disposeBag = DisposeBag()
            
            Observable<String>.create { observer in
             
                observer.onNext("R2-D2")
                observer.onNext("C-3PO")
                observer.onError(Droid.OU812)
                //it will stop at the error and won't emmit anymore data!
                observer.onNext("K-2SO")
                observer.onCompleted()
                
                return Disposables.create()
            }.subscribe(onNext: {print($0)}, onError: {print("ERROR: " , $0)}, onCompleted: {print("Completed")}, onDisposed: {print("Disposed")})
            .disposed(by: disposeBag)
            
            //WARNING: if we comment out onError , onComplete and disposedBy , it'll cause a memory leak !
        }
        
        //MARK: Single
        example(of: "Single"){
            enum FileReadError: Error {
                case fileNotFound , unreadable , encodingFailed
            }
            
            func loadText(from fileName: String) -> Single<String> {
                return Single.create { single in
                    let disposable = Disposables.create()
                    guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
                        single(.error(FileReadError.fileNotFound))
                        return disposable
                    }
                    
                    guard let data = FileManager.default.contents(atPath: path) else {
                        single(.error(FileReadError.unreadable))
                        return disposable
                    }
                    
                    guard let content = String(data: data, encoding: .utf8) else {
                        single(.error(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    single(.success(content))
                    return disposable
                }
            }
            
            loadText(from: "ANewHope").subscribe{
                switch $0 {
                case .success(let string):
                    print(string)
                case .error(let error):
                    print(error)
                }
            }
        }
        
        
        
    }
}
