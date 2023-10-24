//
//  ExporeEventsTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

protocol ExploreEventsTableViewCellProtocol {
    func joinBtnSleceted(cell: ExploreEventsTableViewCell, row: Int)
}

class ExploreEventsTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var hotEventsCollectionView: UICollectionView!

    static let identifier = "ExploreEventsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ExploreEventsTableViewCell", bundle: nil)
    }
    
    var delegate: ExploreEventsTableViewCellProtocol?
    var eventsList = [Event]()
    var firstTime = true

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
        self.hotEventsCollectionView.register(EventsCollectionViewCell.nib(), forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)
    }

    // config cell..
    func configCell(events: [Event]){
        self.eventsList = events
        if firstTime{
            self.hotEventsCollectionView.reloadInputViews()
//            self.hotEventsCollectionViewCell.u
            self.hotEventsCollectionView.reloadData()
            self.firstTime = false
        }
    }
}

// MARK: - CollectionView Delegates & Datasource

extension ExploreEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.hotEventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath) as? EventsCollectionViewCell else{
            return cell
        }
        listCell.joinBtn.tag = indexPath.row
        listCell.completedEventView.isHidden = true
        listCell.hotEventView.isHidden = false
        let dict = self.eventsList[indexPath.row]
        listCell.eventNameLbl.text = dict.name
        listCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
        listCell.noOfPeopleJoinedLbl.text = "\(dict.peopleJoinedCount ?? 0) People joined"
        listCell.eventCreatedByUserLbl.text = dict.creator?.name ?? emptyStr
        // 2023-10-26
        let date = CommonFxns.changeDateToFormat(date: dict.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
        print(date)
        listCell.dateTimeLbl.text = "\(date)\n \(dict.time ?? emptyStr)"
        
        let imgrUrl = dict.bannerImage?.image ?? emptyStr
        listCell.eventImgView.sd_setImage(with: URL(string: imgrUrl), placeholderImage:UIImage(named: "defaultEventImg"), options: .allowInvalidSSLCertificates, completed: nil)
        
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: self.hotEventsCollectionView.frame.width-10, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("didSelectItemAt")
        self.delegate?.joinBtnSleceted(cell: self, row: indexPath.row)
    }
    
}
