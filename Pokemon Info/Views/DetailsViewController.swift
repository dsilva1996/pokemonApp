//
//  DetailsViewController.swift
//  Pokemon Info
//
//  Created by Daniel Silva on 02/05/2021.
//

import Foundation
import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var viewImage: UIView!
    @IBOutlet var ImgViewAvatar: UIImageView!
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var btnMale: UIButton!
    @IBOutlet var btnFemale: UIButton!
    @IBOutlet var btnFavourite: UIButton!
    @IBOutlet var stackViewButtons: UIStackView!
    @IBOutlet var stackViewHeight: NSLayoutConstraint!
    
    @IBOutlet var lblTitleStatOne: UILabel!
    @IBOutlet var lblStatOne: UILabel!
    @IBOutlet var lblTitleStatTwo: UILabel!
    @IBOutlet var lblStatTwo: UILabel!
    @IBOutlet var lblTitleStatThree: UILabel!
    @IBOutlet var lblStatThree: UILabel!
    @IBOutlet var lblTitleStatFour: UILabel!
    @IBOutlet var lblStatFour: UILabel!
    @IBOutlet var lblTitleStatFive: UILabel!
    @IBOutlet var lblStatFive: UILabel!
    @IBOutlet var lblTitleStatSix: UILabel!
    @IBOutlet var lblStatSIx: UILabel!
    
    @IBOutlet var lblWeight: UILabel!
    
    
    //MARK: - Variables
    
    var pokemon: ModelPokemon?
    var statLabels: [UILabel] = []
    var statTitleLabels: [UILabel] = []
    
    
    //MARK: - Override Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
        self.setupData()
    }
    
    
    //MARK: - Functions
    
    init(pokemon: ModelPokemon) {
        
        super.init(nibName: nil, bundle: nil)
        self.pokemon = pokemon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        statTitleLabels.append(lblTitleStatOne)
        statLabels.append(lblStatOne)
        statTitleLabels.append(lblTitleStatTwo)
        statLabels.append(lblStatTwo)
        statTitleLabels.append(lblTitleStatThree)
        statLabels.append(lblStatThree)
        statTitleLabels.append(lblTitleStatFour)
        statLabels.append(lblStatFour)
        statTitleLabels.append(lblTitleStatFive)
        statLabels.append(lblStatFive)
        statTitleLabels.append(lblTitleStatSix)
        statLabels.append(lblStatSIx)
        btnMale.backgroundColor = UIColor.darkGray
        btnFemale.backgroundColor = UIColor.white
    }
    
    func setupData() {
        
        if let model = self.pokemon {
            
            title = model.name
            applyDefaultImage()
            setupSexButtons()
            applyStats()
            lblWeight.text = String(model.weight ?? 0)
        }
    }
    
    func setupSexButtons() {
        
        stackViewHeight.constant = pokemon?.sprites?.front_female == nil ? 0 : 40
        btnMale.isHidden = pokemon?.sprites?.front_female == nil
        btnFemale.isHidden = pokemon?.sprites?.front_female == nil
    }
    
    func applyDefaultImage() {
        
        if let maleImage = pokemon?.sprites?.front_default?.getImageFromURL() {
            
            ImgViewAvatar.image = maleImage
        }
    }
    
    func applyFemaleImage() {
        
        if let femaleImage = pokemon?.sprites?.front_female?.getImageFromURL() {
            
            ImgViewAvatar.image = femaleImage
        }
    }
    
    func applyStats() {
        
        if let stats = pokemon?.stats {
            
            for i in 0...stats.count - 1  {
                
                statLabels[i].text = String(stats[i].base_stat ?? 0)
                
                if let stat = stats[i].stat {
                    
                    statTitleLabels[i].text = stat.name
                }
            }
        }
    }
    
    func callPost() {
        
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(pokemon)
            let dictionary = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            AF.request(URL.init(string: "https://webhook.site/baf4233f-a5e9-40f3-a5fb-4bf22562ef7e")!, method: .post, parameters: dictionary, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response.result)
                
                switch response.result {
                
                case .success(_):
                    debugPrint("SUCCESS")
                    break
                case .failure(let error):
                    debugPrint(error)
                    break
                }
            }
            
        } catch {
            
            debugPrint("ERROR")
        }
    }
    
    
    //MARK: - Actions
        
    @IBAction func btnFavouritePressed(_ sender: Any) {
        
        btnFavourite.tintColor = UIColor.red
        btnFavourite.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        
        callPost()
    }
    
    @IBAction func btnMalePressed(_ sender: Any) {
        
        self.applyDefaultImage()
        btnMale.backgroundColor = UIColor.darkGray
        btnFemale.backgroundColor = UIColor.white
    }
    
    @IBAction func btnFemalePressed(_ sender: Any) {
        
        self.applyFemaleImage()
        btnFemale.backgroundColor = UIColor.darkGray
        btnMale.backgroundColor = UIColor.white
    }
}
