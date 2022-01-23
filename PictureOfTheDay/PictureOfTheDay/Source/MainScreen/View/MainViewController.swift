//
//  MainViewController.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 22/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    enum Constants {
        static let errorTitle = "Error"
        static let pastImageMessage = "We are not connected to the internet, showing you the last image we have."
        static let noImageMessage = "We are unable to fetch Picture, please check your internet and try again."
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var discriptionView: UIView!
    
    lazy var presnter: MainViewPresenter = { MainViewPresenter(view: self) }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presnter.mainViewLoaded()
    }
    
    @IBAction func didTapOnButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.headerView.isHidden = sender.isSelected
            self?.discriptionView.isHidden = sender.isSelected
        }
    }
}

extension MainViewController: MainViewable {
    
    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicatorAndShowNoDataError() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.showErrorMessage(Constants.noImageMessage)
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func showDetails(title: String, details: String, isPastImage: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = title
            self?.descriptionLabel.text = details
            self?.errorLabel.text = isPastImage ? Constants.pastImageMessage : ""
        }
    }
    
    func hideLoadingIndicatorAndShowImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
    
    func hideLoadingIndicatorAndShowNoImageError() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.showErrorMessage(Constants.pastImageMessage)
        }
    }
    
    func showErrorMessage(_ message: String) {
        self.errorLabel.text = message
    }
}


