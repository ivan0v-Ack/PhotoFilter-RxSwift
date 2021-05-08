//
//  FilterService.swift
//  HelloRxSwift
//
//  Created by Ivan Ivanov on 5/8/21.
//

import UIKit
import CoreImage
import RxSwift
import RxCocoa

class FilterService {
    
    static var shared = FilterService()
    
    private var context: CIContext
    
    private init() {
        self.context = CIContext()
    }
    
   func applyFilter(to inputImage: UIImage) -> Observable<UIImage>{
    Observable.create { observer in
        let filter = CIFilter(name: "CICMYKHalftone")!
    filter.setValue(5.0, forKey: kCIInputWidthKey)
    
    if let sourceImage = CIImage(image: inputImage) {
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            observer.onNext(processedImage)
            
        }
    }
        return Disposables.create()
    }
    
    }
    
    
}
    
