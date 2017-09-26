import RxSwift

/// MARK: RxSwift Operators

/*
 All operators can be found at: http://reactivex.io/documentation/operators.html
 */
let disposeBag = DisposeBag()
let scheduler = SerialDispatchQueueScheduler(qos: .default)

/// MARK: - Transforming Operators

// Map
Observable.of(1, 2, 3)
  .map{item in item + 10}
  .subscribe(onNext: {print($0)})
  .disposed(by: disposeBag)

// FlatMap
Observable.of(["inu", "neko", "ga", "peguine"])
  .flatMap { (items) -> Observable<String> in
    return Observable.from(items)
  }
  .subscribe(onNext: {
    print($0)})
  .disposed(by: disposeBag)

// Another example of flatMap, flatMapLatest, and flatMapFirst
struct Player {
  var score: Variable<Int>
}

let 👦🏻 = Player(score: Variable(80))
let 👧🏼 = Player(score: Variable(90))

let player = Variable(👦🏻)

player.asObservable()
  .flatMap { $0.score.asObservable() } // Change flatMap to flatMapLatest/flatMapFirst and observe change in printed output
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

👦🏻.score.value = 85

player.value = 👧🏼 // Will be printed when using flatMap/flatMapLatest, but will not be printed when using flatMapFirst

👦🏻.score.value = 95 // Will be printed when using flatMap/flatMapFirst, but will not be printed when using flatMapLatest

👧🏼.score.value = 100 // Will be printed when using flatMap/flatMapLatest, but will not be printed when using flatMapFirst

// Scan
Observable.of(1, 5, 10)
  .scan(0, accumulator: {$0 + $1})
  .subscribe(onNext: {print($0)})
  .disposed(by: disposeBag)

// TODO: Buffer, GroupBy, Window

/// MARK: - Filtering Operators

// Filter
Observable.of(1, 2, 3, 4, 5, 6)
  .filter{$0 % 2 == 0}
  .subscribe(onNext: {print($0)})
  .disposed(by: disposeBag)

// Distinct
Observable.of(1, 1, 1,2, 2, 3, 4, 4, 5, 6)
  .distinctUntilChanged()
  .subscribe(onNext: {print($0)})
  .disposed(by: disposeBag)

// ElementAt
Observable.of(1, 2, 3, 4, 5, 6)
  .elementAt(3)
  .subscribe(onNext: {print($0)})
  .disposed(by: disposeBag)

/// MARK: - Combining Operators

// StartWith
Observable.of("🐱", "🐰", "🐶", "🐸")
  .startWith("☀️")
  .startWith("❄️")
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

// Merge
let source1 = PublishSubject<String>()
let source2 = PublishSubject<String>()
let source3 = PublishSubject<String>()
Observable.of(source1, source2, source3)
  .merge()
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)
source1.onNext("#")
source1.onNext("*")
source2.onNext("-")
source3.onNext("^^")
source2.onNext("+")

// Zip
let zipSource1 = PublishSubject<String>()
let zipSource2 = PublishSubject<Int>()

Observable.zip(zipSource1, zipSource2) { stringElement, intElement in
  "\(stringElement) \(intElement)"
  }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

zipSource1.onNext("🌲")
zipSource1.onNext("🌳")

zipSource2.onNext(1)

zipSource2.onNext(2)

zipSource1.onNext("🍊")
zipSource2.onNext(3)

// CombineLatest
let combineSource1 = PublishSubject<String>()
let combineSource2 = PublishSubject<Int>()

Observable.zip(combineSource1, combineSource2) { stringElement, intElement in
  "\(stringElement) \(intElement)"
  }
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)

combineSource1.onNext("🅰️")
combineSource1.onNext("🅱️")

combineSource2.onNext(1)

combineSource2.onNext(2)

combineSource1.onNext("🆎")
combineSource2.onNext(3)

/// TODO MARK: - Error-handling Operators

/// TODO MARK: - Conditional Operators

/// TODO MARK: - Mathematical and Aggregate Operators



