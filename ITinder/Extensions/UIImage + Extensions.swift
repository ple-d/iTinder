import UIKit

// Расширение функционала класса UIImage
// Реализуем метод, который позволяет получить изображение исходя из цвета и размера
// При передаче UIColor.clear возвращает прозрачное изображение
// Полученное изображение будет использовано для установки его как фонового для UITabBar

extension UIImage {
    static func getColorImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }

    static func getGradientImage(colors: [UIColor], size: CGSize) -> UIImage? {
        //turn color into cgcolor
            let colors = colors.map{$0.cgColor}
            //begin graphics context
            UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            // From now on, the context gets ended if any return happens
            defer {UIGraphicsEndImageContext()}
            //create core graphics context
            let locations:[CGFloat] = [0, 1]
            guard let gredient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as NSArray as CFArray, locations: locations) else {
                return nil
            }
            //draw the gradient
            context.drawLinearGradient(gredient, start: CGPoint(x:0, y: 0), end: CGPoint(x: 0, y:size.height), options: [])
            // Generate the image (the defer takes care of closing the context)
            return UIGraphicsGetImageFromCurrentImageContext()
    }
}
