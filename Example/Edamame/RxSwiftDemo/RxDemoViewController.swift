//
//  RxDemoViewController.swift
//  Edamame
//
//  Created by Matsuo Keisuke on 5/2/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Edamame
import RxSwift

class RxDemoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.alwaysBounceVertical = true
            dataSource = RxDemoViewModel(collectionView: collectionView)
        }
    }
    var dataSource: RxDemoViewModel!
    
    deinit {
        print("[DEINIT]", self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.dataSource.setNeedsLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class RxDemoViewModel: Edamame {
    func loadData(completion:(users: [RxUser]) -> Void) {
        var users = [RxUser]()
        for _ in 0...100 {
            users.append(RxUser(name: "foo", message: "Rx, reactive extensions, originally for .NET, later ported to other languages and environments"))
            users.append(RxUser(name: "bar", message: "Rx, reactive extensions, originally for .NET, later ported to other languages and environments"))
            users.append(RxUser(name: "hoge", message: "Rx, reactive extensions, originally for .NET, later ported to other languages and environments"))
            users.append(RxUser(name: "fuga", message: "Rx, reactive extensions, originally for .NET, later ported to other languages and environments"))
        }
        completion(users: users)
    }
    func setup() {
        self.registerNibFromClass(RxDemoCell.self)
        self.loadData { (users) -> Void in
            let section = self.createSection()
            for user in users {
                section.appendItem(user, cellType: RxDemoCell.self) { (item, indexPath) -> Void in
                    guard let user = item as? RxUser else { return }
                    user.message = user.message + " tapped"
                }
            }
            self.reloadData()
        }
    }
}