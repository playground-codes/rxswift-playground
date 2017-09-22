import RxSwift

/// Documentation: https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md#observables-aka-sequences

/// MARK - Observables

/*
 Observable sequence is just a sequence. Compared with Swift's Sequence, Observable can receive elements asynchronously.
 - Obserable is equivalent to Sequence.
 - Observable.subscribe method is equivalent to Sequence.makeIterator method.
 
 When a sequence sends "completed" or "error" event, all internal resources that compute sequence elements will be free.
 To cancel production of sequence emmediately immediately, call dispose on the returned subscription.
 */

// Creates a new observable without any observer (subscriber).
// There is no subsription yet, so observable will not be executed.
let _ = Observable<String>.create{string -> Disposable in
  print("It should not be printed")
  string.on(.next("New item"))
  string.on(.completed)
  return Disposables.create()
}

let _ = Observable<String>.create{string -> Disposable in
  print("It should be printed")
  string.on(.next("New item"))
  string.on(.completed)
  return Disposables.create()
  }
  .subscribe{
    event in
    print(event)
}

/// MARK: Disposing
// We should not call dipose manually. It is better to use "DisposeBag" and "takeUntil".

let scheduler = SerialDispatchQueueScheduler(qos: .default)
let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
  .subscribe { event in
    print(event)
}
Thread.sleep(forTimeInterval: 2.0)
subscription.dispose()

// Dispose Bag
let disposeBag = DisposeBag()
Observable.of("🐳","🐢", "🐠")
  .subscribe(onNext: {
    print($0)
  }, onError: {
    print($0.localizedDescription)
  }, onCompleted: {
    print("On completed")
  })
  .disposed(by: disposeBag)
