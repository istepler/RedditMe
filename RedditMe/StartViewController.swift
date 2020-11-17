//
//  StartViewController.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: Just a dummy ViewController for start
    
    @IBOutlet weak var startButton: UIButton!

    private let authService: AuthorizationService = AuthorizationService()
    @IBAction func onStart(_ sender: Any) {
        authService.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 30
    }
    static func present(in viewController: UIViewController) {
        let ctrl = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: self))
        ctrl.modalPresentationStyle = .overFullScreen
        viewController.present(ctrl, animated: true)
    }
}
