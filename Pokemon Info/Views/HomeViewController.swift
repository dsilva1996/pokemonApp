//
//  ViewController.swift
//  Pokemon Info
//
//  Created by Daniel Silva on 02/05/2021.
//

import Foundation
import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var imgViewAvatar: UIImageView!
    @IBOutlet var btnDetails: UIButton!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var viewNoResults: UIView!
    @IBOutlet var viewHud: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Variables
    
    var pokemon: ModelPokemon?
    
    
    //MARK: - Override Functions

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
        self.callApi(searchText: "ditto")
    }
    
    
    //MARK: - Functions
    
    func setupView() {
        
        title = "Pokemon"
        imgViewAvatar.isHidden = true
        viewHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        txtSearch.autocorrectionType = .no
    }
    
    func callApi(searchText: String) {
        
        AF.request(URL(string: "https://pokeapi.co/api/v2/pokemon/" + searchText.lowercased())!, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            
            if response.response?.statusCode == 404 {
                
                self.showHud(show: false)
                self.showNoResults(show: true)
                
            } else {
                
                if let responseData = response.data {
                    
                    do {
                        
                        let jsonData = responseData
                        self.pokemon = try! JSONDecoder().decode(ModelPokemon.self, from: jsonData)
                        self.applyData()
                    }
                }
            }
        }
    }
    
    func applyData() {
        
        showNoResults(show: false)
        showHud(show: false)
        imgViewAvatar.isHidden = false
        
        if let name = pokemon?.name {
            
            lblName.text = name
        }
        
        if let images = pokemon?.sprites,
           let imageDefaultString = images.front_default,
           let image = imageDefaultString.getImageFromURL() {
            
            imgViewAvatar.image = image
        }
    }
    
    func showNoResults(show: Bool) {
        
        viewNoResults.isHidden = !show
        lblName.isHidden = show
    }
    
    func showHud(show: Bool) {
        
        viewHud.isHidden = !show
        
        if show {
            
            activityIndicator.startAnimating()
            
        } else {
            
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func btnSearchPressed(_ sender: Any) {
     
        if let text = txtSearch.text {

            showHud(show: true)
            self.callApi(searchText: text)
        }
    }
    
    @IBAction func btnDetailsPressed(_ sender: Any) {
        
        if let model = self.pokemon {
            
            let detailsVC = DetailsViewController(pokemon: model)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
