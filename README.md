# LWTSegementController
![无题](http://ok841h9gr.bkt.clouddn.com/%E6%96%B0%E9%97%BB%E6%8E%A7%E5%88%B6%E5%99%A8.gif)
### 使用方式
``` Swift
let segementVC = LWTSegementViewController()
//设置栏目的标题数组
segementVC.titleArray = ["社会","科技","娱乐","体育","美女","动物"]
//设置每个栏目的控制器数组
for (_, _) in segementVC.titleArray.enumerated() {
     let vc = TestViewController()
    segementVC.controllerArray.append(vc)
}
self.navigationController?.pushViewController(segementVC, animated: true)
```
