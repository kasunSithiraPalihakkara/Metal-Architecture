
import MetalKit

enum Colors {
    static let wenderlichGreen = MTLClearColor(red: 1.0,
                                               green: 1.0,
                                               blue: 1.0,
                                               alpha: 1.0)
}



class ViewController: UIViewController {
    var touchPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    var metalView: MTKView {
       
        return view as! MTKView
    }
    
    var renderer: Renderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  var metalView:MTKView = view as! MTKView
        metalView.device = MTLCreateSystemDefaultDevice()
        metalView.framebufferOnly =  true
        // metalView.presentsWithTransaction = true
        
    
        //   metalView.layer.isOpaque = false
        guard let device = metalView.device else {
            fatalError("Device not created. Run on a physical device")
        }
        
        metalView.clearColor =  Colors.wenderlichGreen
        
        
        renderer = Renderer(device: device)
        setupGestures()
        
//      renderer?.tapReceived(position: touchPoint)
        metalView.delegate = renderer
        
        
    }
    
    
    //MARK: - Gesture related
    
    func setupGestures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan))
        self.view.addGestureRecognizer(pan)
    }
    
    
    @objc func pan(panGesture: UIPanGestureRecognizer){
        if panGesture.state == UIGestureRecognizerState.changed {
            let pointInView = panGesture.location(in: self.view)
            print("pointInView:\(pointInView)")
            
            touchPoint = convertCoodinates(tapx:pointInView.x , tapy:pointInView.y )
            print("touchPoint:\(touchPoint)")
            renderer?.tapReceived(position: touchPoint)
            
        } else if panGesture.state == UIGestureRecognizerState.began {
           
        }else if panGesture.state == UIGestureRecognizerState.ended{
      
        }
    }
    
    func convertCoodinates(tapx:CGFloat,tapy:CGFloat) -> CGPoint{
        
        let deviceWidth:CGFloat = CGFloat(self.view.frame.size.width)
        let deviceHeight:CGFloat = CGFloat(self.view.frame.size.height )
        print("deviceWidth:\(deviceWidth)")
        
        var touchPoint:CGPoint = CGPoint(x: 0.0, y: 0.0)
        
        if (tapx <= deviceWidth/2) && (tapy <= deviceHeight/2) {
            touchPoint.x = (tapx / deviceWidth) * 2 - 1
            touchPoint.y = -(tapy / deviceHeight) * 2 + 1
        }else if (tapx > deviceWidth/2) && (tapy <= deviceHeight/2) {
            touchPoint.x = (tapx / deviceWidth) * 2 - 1
            touchPoint.y = -(tapy / deviceHeight) * 2 + 1
        }else if (tapx <= deviceWidth/2) && (tapy > deviceHeight/2) {
            touchPoint.x = (tapx / deviceWidth) * 2 - 1
            touchPoint.y = -(tapy / deviceHeight) * 2 + 1
        }else if (tapx > deviceWidth/2) && (tapy > deviceHeight/2) {
            touchPoint.x = (tapx / deviceWidth) * 2 - 1
            touchPoint.y = -(tapy / deviceHeight) * 2 + 1
        }
        
        return touchPoint
    }
    
}

