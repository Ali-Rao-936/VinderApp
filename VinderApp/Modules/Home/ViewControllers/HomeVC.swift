//
//  HomeVC.swift
//  VinderApp
//
//  Created by iOS Dev on 11/10/2023.
//

import UIKit
import Koloda
import SDWebImage

class HomeVC: UIViewController {

    @IBOutlet weak var cardView: KolodaView!
    @IBOutlet weak var viewContainerForButtons: UIView!
    
    var arrayOfUsers = [User]()
    let viewModel = UserViewModel(userType: .allUsers)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
        callToViewModelForUIUpdate()
    }
    
    func initialSetup() {
        cardView.dataSource = self
        cardView.delegate = self
        cardView.layer.cornerRadius = 12.0
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        CommonFxns.showProgress()
        self.viewModel.bindUserViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.arrayOfUsers = viewModel.userList.data ?? []
        viewContainerForButtons.isHidden = false
        cardView.reloadData()
    }
    
    @IBAction func buttonLikeDislikeAction(_ sender: UIButton) {
        if sender.tag == 1 {  //Dislike User
            cardView?.swipe(.left)
            
        }else { // Like User
            cardView?.swipe(.right)
        }
    }
    
    // MARK: - Button Actions
    @IBAction func profileBtnAction(_ sender: Any) {
        let otherVCObj = ProfileVC(nibName: enumViewControllerIdentifier.profileVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
}

// MARK: KolodaViewDelegate

extension HomeVC: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        let position = cardView.currentCardIndex
//        for i in 1...4 {
//          dataSource.append(UIImage(named: "Card_like_\(i)")!)
//        }
//        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
        viewContainerForButtons.isHidden = true
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print("ID--\(arrayOfUsers[Int(index)].id ?? 0)")
        let otherVCObj = UserDetailVC(nibName: enumViewControllerIdentifier.userDetailVC.rawValue, bundle: nil)
        otherVCObj.selectedUserId = arrayOfUsers[Int(index)].id ?? 0
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            let viewModel = UserViewModel(userType: .likedUser, userID: arrayOfUsers[index].id)
               viewModel.bindUserViewModelToController = {
                print("Liked User")
            }
        }
    }
}

// MARK: KolodaViewDataSource

extension HomeVC: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return arrayOfUsers.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: arrayOfUsers[Int(index)].profileImg ?? ""), placeholderImage:UIImage(named: "defaultEventImg"), context: nil)
    //    imageView.image = UIImage(named: "defaultUserProfileImg")
        
        let label = UILabel()
        let levelImageView = UIImageView()
        label.addSubview(levelImageView)
        imageView.addSubview(label)
        levelImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -100).isActive = true
        label.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 20).isActive = true
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.text = arrayOfUsers[Int(index)].name ?? "User \(Int(index))"
        label.textColor = UIColor.white
        
        levelImageView.image = UIImage(named: "levelIcon")
        levelImageView.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        levelImageView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -20).isActive = true
        
        let gradientImageView = UIImageView()
        gradientImageView.image = UIImage(named: "gradientImg2")
        gradientImageView.backgroundColor = .clear
        imageView.addSubview(gradientImageView)
        gradientImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        gradientImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        gradientImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        
        return imageView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

