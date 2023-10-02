//
//  MyMatchVC.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

class MyMatchVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var upcomingEventsList = ["1", "2"]
    var pastEventsList = ["1", "2", "3"]
    var events = [String]()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.matchesCollectionView.register(MatchesCollectionViewCell.nib(), forCellWithReuseIdentifier: MatchesCollectionViewCell.identifier)
        //
        self.events = self.upcomingEventsList
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func segmentControlValuechanged(_ sender: Any) {
        if self.segmentControl.selectedSegmentIndex == 0{
            self.events = self.upcomingEventsList
        }else{
            self.events = self.pastEventsList
        }
        self.matchesCollectionView.reloadData()
    }

}

// MARK: - CollectionView Delegates & Datasource

extension MyMatchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            return self.upcomingEventsList.count
        default:
            return self.pastEventsList.count
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.matchesCollectionView.dequeueReusableCell(withReuseIdentifier: MatchesCollectionViewCell.identifier, for: indexPath) as? MatchesCollectionViewCell else{
            return cell
        }

        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: (self.matchesCollectionView.frame.width/3)-30, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = self.playersList[indexPath.row]
//        self.goToPlayerDetailScreen(dict: dict)
    }
    
}
