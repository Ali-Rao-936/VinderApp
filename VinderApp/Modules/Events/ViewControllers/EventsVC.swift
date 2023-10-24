//
//  EventsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class EventsVC: UIViewController, EventsVCTableViewHeaderProtocol {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

//    var hotEventsArr = ["1", "2"]
//    var allEventsArr = ["1", "2", "3"]
//    let eventsHeadingsList = ["Hot events", "More events"]
        
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    func initialSetup(){
        hideKeyboardWhenTappedAround() // hide keyboard
        self.updateView(tag: 0) // Container view Setup
    }
    
    private func updateView(tag: Int) {
        if tag == 0 {
            remove(asChildViewController: myEventsVC)
            add(asChildViewController: exploreEventsVC)
        } else{
            remove(asChildViewController: exploreEventsVC)
            add(asChildViewController: myEventsVC)
        }
    }

    // MARK: - Button Actions

    @IBAction func searchBtnAction(_ sender: Any) {
    }
    
    @IBAction func segmentControlValuechanged(_ sender: UISegmentedControl) {
        self.updateView(tag: sender.selectedSegmentIndex)
    }
    
    // Actions
    func createEventBtnSelected(header: EventsVCTableViewHeader) {
        print("create Event....")
        let otherVCObj = CreateEventVC(nibName: enumViewControllerIdentifier.createEventVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    func joinBtnSleceted(cell: ExploreEventsTableViewCell) {
        print("Joiiin btn ...")
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
      //  otherVCObj.eventType = EventType.joinEvent.rawValue
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    func viewBtnSleceted(cell: ExploreEventsTableViewCell) {
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
     //   otherVCObj.eventType = EventType.alreadyJoined.rawValue
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
        
    // MARK: - SetUp container view methods

    private lazy var exploreEventsVC: ExploreEventsVC = {
        // Load XIB
        
        let otherVCObj = ExploreEventsVC(nibName: enumViewControllerIdentifier.exploreEventsVC.rawValue , bundle: nil)

        self.add(asChildViewController: otherVCObj)

        return otherVCObj
    }()
    
    private lazy var myEventsVC: MyEventsVC = {
        // Load XIB
        
        let otherVCObj = MyEventsVC(nibName: enumViewControllerIdentifier.myEventsVC.rawValue , bundle: nil)

        // Add View Controller as Child View Controller
        self.add(asChildViewController: otherVCObj)

        return otherVCObj
    }()

    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        
        viewController.view.frame = self.containerView.bounds
        self.containerView.addSubview(viewController.view)
        
//        // Define Constraints
//        NSLayoutConstraint.activate([
//            viewController.view.topAnchor.constraint(equalTo: self.containerView.topAnchor),
//            viewController.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
//            viewController.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
//            viewController.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
//        ])
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
 
    
}

