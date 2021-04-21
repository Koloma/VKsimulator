//
//  AsyncImageView.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 20.04.2021.
//

import UIKit

class AsyncImageView: UIImageView {
    
    private var _image: UIImage?
    
    override var image: UIImage?{
        get{
            return _image
        }
        set{
            
            _image = newValue
            // Сбрасываем содержимое слоя
            layer.contents = nil
            guard let image = newValue else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                let decodedCGImage = self.decode(image)
                DispatchQueue.main.async {
                    self.layer.contents = decodedCGImage
                }
            }
        }
    }

    private func decode(_ image: UIImage) -> CGImage? {
         guard let newImage = image.cgImage else { return nil }
        
        if let cachedImage = AsyncImageView.cache.object(forKey: image) {
            return (cachedImage as! CGImage)
        }
        
        // Создаем цветовое пространство для рендеринга
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // Создаем «чистый» графический контекст
        let context = CGContext(data: nil,
                                width: newImage.width,
                                height: newImage.height,
                                bitsPerComponent: 8,
                                bytesPerRow: newImage.width * 4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        // Рассчитываем cornerRadius для закругления
        //let imgRect = CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height)
        //let maxDimension = CGFloat(max(newImage.width, newImage.height))
        //let cornerRadiusPath = UIBezierPath(roundedRect: imgRect, cornerRadius: maxDimension / 2 ).cgPath
        //context?.addPath(cornerRadiusPath)
        //context?.clip()
        // Изображение в контекст
        context?.draw(newImage, in: CGRect(x: 0,
                                           y: 0,
                                           width: newImage.width,
                                           height: newImage.height))
        
        guard let drawnImage = context?.makeImage() else { return nil }
        AsyncImageView.cache.setObject(drawnImage, forKey: image)
        return drawnImage
    }
}
extension AsyncImageView { private struct Cache {
    static var instance = NSCache<AnyObject, AnyObject>() }
    class var cache: NSCache<AnyObject, AnyObject> {
        get { return Cache.instance }
        set { Cache.instance = newValue }
    }
}

