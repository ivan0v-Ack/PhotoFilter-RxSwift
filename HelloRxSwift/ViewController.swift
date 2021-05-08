//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Ivan Ivanov on 5/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
     
    }
    
    let disposeBag = DisposeBag()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToPhotos" {
            let photoVC = segue.destination as! PhotosCollectionViewController
            photoVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
                DispatchQueue.main.async {
                    self?.updateUI(photo: photo)
                }
               
                
            }).disposed(by: disposeBag)
        }
        
    }
    
    func updateUI(photo: UIImage) {
        imageViewPhoto.image = photo
       btnOutlet.isHidden = false
    }
    
    @IBAction func btnPressed() {
        
        guard let sourceImage = imageViewPhoto.image else { return }
        FilterService.shared.applyFilter(to: sourceImage)
            .subscribe(onNext: { [weak self] nextImage in
                DispatchQueue.main.async {
                    self?.imageViewPhoto.image = nextImage
                }
            }).disposed(by: disposeBag)
        
        
    }


}

