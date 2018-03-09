//
//  ImagePickerAction.swift
//  ImagePickerTrayController
//
//  Created by Laurin Brandner on 22.11.16.
//  Copyright © 2016 Laurin Brandner. All rights reserved.
//

import Foundation

public struct ImagePickerAction {
    
    public typealias Callback = (ImagePickerAction) -> ()
    
    public var title: String
    public var image: UIImage
    public var callback: Callback
    public var tintColor: UIColor
    
    public static func photoAction(tintColor: UIColor = .lightGray, callback: @escaping Callback) -> ImagePickerAction {
        let image = UIImage(bundledName: "ImagePickerAction-Camera")!
        
        return ImagePickerAction(title: NSLocalizedString("Photo", comment: "Image Picker Camera Action"), image: image, callback: callback, tintColor: tintColor)
    }
    
    public static func videoAction(tintColor: UIColor = .lightGray, callback: @escaping Callback) -> ImagePickerAction {
        let image = UIImage(bundledName: "ImagePickerAction-Video")!
        
        return ImagePickerAction(title: NSLocalizedString("Video", comment: "Image Picker Camera Action"), image: image, callback: callback, tintColor: tintColor)
    }
    
    public static func libraryAction(tintColor: UIColor = .lightGray, callback: @escaping Callback) -> ImagePickerAction {
        let image = UIImage(bundledName: "ImagePickerAction-Library")!
        
        return ImagePickerAction(title: NSLocalizedString("Library", comment: "Image Picker Photo Library Action"), image: image, callback: callback, tintColor: tintColor)
    }
    
    func call() {
        callback(self)
    }
    
}
