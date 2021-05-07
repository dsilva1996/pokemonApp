//
//  DetailsViewController.swift
//  Pokemon Info
//
//  Created by Daniel Silva on 02/05/2021.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet var viewImage: UIView!
    @IBOutlet var ImgViewAvatar: UIImageView!
    @IBOutlet var viewDetails: UIView!
    @IBOutlet var btnMale: UIButton!
    @IBOutlet var btnFemale: UIButton!
    
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
        btnMale.backgroundColor = UIColor.gray
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
        
        btnMale.isEnabled = pokemon?.sprites?.front_default != nil
        btnFemale.isEnabled = pokemon?.sprites?.front_female != nil
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
    
    
    //MARK: - Actions
    
    @IBAction func btnMalePressed(_ sender: Any) {
        
        self.applyDefaultImage()
        btnMale.backgroundColor = UIColor.gray
        btnFemale.backgroundColor = UIColor.white
    }
    
    @IBAction func btnFemalePressed(_ sender: Any) {
        
        self.applyFemaleImage()
        btnFemale.backgroundColor = UIColor.gray
        btnMale.backgroundColor = UIColor.white
    }
}
