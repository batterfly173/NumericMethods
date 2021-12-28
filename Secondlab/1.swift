import Foundation

extension Diff {
    
    //MARK: - Разница с центральными разностями
    func differenceFor1(h: Double) -> Double {
        let temp = Diff().calculateDiff1Center(x0: -15, xK: 15, h: h)
        let y = temp.ys
        let x = temp.xs
        
        var diff: Double = Double(Int.min)
        for (index, element) in x.enumerated() {
            let t = originalDiff(x: element) - y[index]
            if t > diff {
                diff = t
            }
        }
        
        return diff
    }
    
    func differenceFor2(h: Double) -> Double {
        let temp = Diff().calculateDiff1Right(x0: -15, xK: 15, h: h)
        let y = temp.ys
        let x = temp.xs
        
        var diff: Double = Double(Int.min)
        
        for i in 0..<min(x.count, y.count) {
            let t = (originalDiff(x: x[i]) - y[i])
            if t > diff {
                diff = t
            }
        }
        
        return diff
    }
    
    
    // MARK: - Первая центральными разностями
    func calculateDiff1Center(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        var xs = [Double]()
        for i in stride(from: x0, to: xK, by: h) {
            xs.append(i)
        }
        
        var ys = [Double]()
        for x in xs {
            ys.append(functionForDiff(x: x))
        }
        
        var F = [Double]()
        let t = -3*ys[0] + 4*ys[1] - ys[2]
        F.append(t/(2*h))
        
        for i in 1..<ys.count - 1 {
            let t1 = (ys[i + 1] - ys[i - 1]) / (2 * h)
            F.append(t1)
        }
        
        let n = ys.count
        let t2 = (3*ys[n-1] - 4*ys[n-2] + ys[n-3]) / (2 * h)
        F.append(t2)
        
        return (xs: xs, ys: F)
    }
    
    // MARK: - Первая правыми разностями
    func calculateDiff1Right(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        var xs = [Double]()
        for i in stride(from: x0, to: xK + h, by: h) {
            xs.append(i)
        }
        
        var ys = [Double]()
        for x in xs {
            ys.append(functionForDiff(x: x))
        }
        
        var F = [Double]()
        
        for i in 0..<ys.count - 1 {
            let t1 = (ys[i + 1] - ys[i]) / h
            F.append(t1)
        }
        
        return (xs: xs, ys: F)
    }
}
