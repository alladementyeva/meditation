//
//  MainViewController.swift
//  Meditation
//
//  Created by user on 27.10.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "moodCell"

class MainViewController: UIViewController //, UICollectionViewDelegate, UICollectionViewDataSource
{

    @IBOutlet weak var userPicture: UIImageView!
    
    let moods = ["Calm", "Relax", "Focus", "Anxious"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! moodCVCell
        
        cell.name.text = moods[indexPath.row]
        cell.picture.image = UIImage(named: cell.name.text!)
        cell.pictureBg.backgroundColor = UIColor(named: "white")
  
        print( cell.name.text )
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 
