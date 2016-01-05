//
//  ViewController.swift
//  Filter
//
//  Created by 谷建兴 on 16/1/5.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    var ciimage:CIImage?
    var cicontext:CIContext?
    
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [String]()
        
        //获取所有滤镜
        arr = CIFilter.filterNamesInCategory(kCICategoryBuiltIn)
        
        //删除无法直接使用的滤镜
        self.dataSource = NSMutableArray(array: arr)
        let delate = NSMutableArray()
        for str in self.dataSource {
            if str.rangeOfString("Mask").length > 0 {
                delate.addObject(str)
            }
        }
        
        self.dataSource.removeObjectsInArray(delate as [AnyObject])
        self.dataSource.removeObject("CIAccordionFoldTransition")
        self.dataSource.removeObject("CIAdditionCompositing")
        self.dataSource.removeObject("CIAztecCodeGenerator")
        self.dataSource.removeObject("CICheckerboardGenerator") //14
        self.dataSource.removeObject("CICode128BarcodeGenerator") //18
        self.dataSource.removeObject("CIColorMap") //27
        self.dataSource.removeObject("CIConstantColorGenerator") //33
        self.dataSource.removeObject("CICopyMachineTransition") //38
        self.dataSource.removeObject("CIFlashTransition") //55
        self.dataSource.removeObject("CIGaussianGradient") //60
        self.dataSource.removeObject("CILenticularHaloGenerator") //74
        self.dataSource.removeObject("CILinearGradient") //78
        self.dataSource.removeObject("CIMaximumCompositing") //83
        self.dataSource.removeObject("CIMinimumCompositing") //85
        self.dataSource.removeObject("CIModTransition") //85
        self.dataSource.removeObject("CIMultiplyCompositing") //87
        self.dataSource.removeObject("CIPageCurlTransition") //90
        self.dataSource.removeObject("CIPDF417BarcodeGenerator") //92
        self.dataSource.removeObject("CIQRCodeGenerator") //108
        self.dataSource.removeObject("CIRadialGradient") //108
        self.dataSource.removeObject("CIRandomGenerator") //108
        self.dataSource.removeObject("CIRippleTransition") //108
        self.dataSource.removeObject("CIShadedMaterial") //112
        self.dataSource.removeObject("CISmoothLinearGradient") //115
        self.dataSource.removeObject("CISourceAtopCompositing") //116
        self.dataSource.removeObject("CISourceInCompositing") //116
        self.dataSource.removeObject("CISourceOutCompositing") //116
        self.dataSource.removeObject("CISourceOverCompositing") //116
        self.dataSource.removeObject("CIStarShineGenerator") //119
        self.dataSource.removeObject("CIStripesGenerator") //119
        self.dataSource.removeObject("CISunbeamsGenerator") //122
        self.dataSource.removeObject("CISwipeTransition")
        
        
        let image:UIImage = UIImage(named: "hudei")!
        
        self.ciimage = CIImage(image: image)!
        self.cicontext = CIContext()
        
        //较好的滤镜
        /*
        CICircularScreen 15
        CIColorInvert 26
        CIColorMonochrome  28  黑白
        CIColorPosterize 30 色调分离
        CICrystallize  39
        CIDepthOfField   41
        CIDiscBlur 43
        CIEdges  49
        CIFalseColor  54
        CIHatchedScreen 65
        CIHexagonalPixellate  66
        CILinearToSRGBToneCurve 78
        CILineOverlay 79
        CIPhotoEffectChrome  96
        CIPhotoEffectInstant  98
        */
        
        
    }

    //轮子个数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //每个轮子item个数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count
    }
    
    //每个item的标题
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataSource[row] as! String
    }
    
    //轮子滚动
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let str:String = self.dataSource[row] as! String
        print(str)
        print(row)
        self.creatCoreImage(name: str, inputciimage: self.ciimage!)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func creatCoreImage(name name:String,inputciimage:CIImage) {
        //实例化 滤镜
        let cifilter:CIFilter = CIFilter(name:name)!
        //设置输入源
        cifilter.setValue(inputciimage, forKey: kCIInputImageKey)
        //初始化
        cifilter.setDefaults()
        //获取相应属性
//        print(cifilter.attributes)
        //输出CIImage
        let endciimage:CIImage =  cifilter.valueForKey(kCIOutputImageKey) as! CIImage
        //输出CGImageRef
        let cgimage:CGImageRef = (self.cicontext?.createCGImage(endciimage, fromRect: endciimage.extent))!
        let endimage:UIImage = UIImage(CGImage: cgimage)
        self.picture.image = endimage
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

