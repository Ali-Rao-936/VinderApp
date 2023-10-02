//
//  ExporeEventsTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

protocol ExploreEventsTableViewCellProtocol {
    func joinBtnSleceted(cell: ExploreEventsTableViewCell)
    func viewBtnSleceted(cell: ExploreEventsTableViewCell)
}

class ExploreEventsTableViewCell: UITableViewCell, EventsCollectionViewCellprotocol {

    // MARK: - Outlets & Properties

    @IBOutlet weak var hotEventsCollectionViewCell: UICollectionView!
//    @IBOutlet weak var usernameLbl: UILabel!
//    @IBOutlet weak var tagsView: TagListView!

    static let identifier = "ExploreEventsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ExploreEventsTableViewCell", bundle: nil)
    }
    
    var delegate: ExploreEventsTableViewCellProtocol?
    var eventsList = [EventModel]()
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func initialSetup(){
        // Register cell
        self.hotEventsCollectionViewCell.register(EventsCollectionViewCell.nib(), forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)
    }
    
    func joinBtnSelected(cell: EventsCollectionViewCell) {
        print("collection Join btn sleceted....")
        self.delegate?.joinBtnSleceted(cell: self)
    }
    
    func viewBtnSelected(cell: EventsCollectionViewCell) {
        print("collection viewBtnSelected...")
        self.delegate?.viewBtnSleceted(cell: self)
    }
    
    func configCell(events: [EventModel]){
        // config cell..
        
        self.eventsList = events
        self.hotEventsCollectionViewCell.reloadData()
    }
}

// MARK: - CollectionView Delegates & Datasource

extension ExploreEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.hotEventsCollectionViewCell.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath) as? EventsCollectionViewCell else{
            return cell
        }
        listCell.delegate = self
        
        let dict = self.eventsList[indexPath.row]
        listCell.eventNameLbl.text = dict.name
        listCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
        
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: self.hotEventsCollectionViewCell.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = self.playersList[indexPath.row]
//        self.goToPlayerDetailScreen(dict: dict)
    }
    
}
