import Foundation

extension Diff {
    //MARK: - Разница с центральными разностями
    func differenceForSecondCenter(h: Double) -> Double {
        let temp = Diff().calculateDiff2Center(x0: -15, xK: 15, h: h)
        let y = temp.ys
        let x = temp.xs
        
        var diff: Double = Double(Int.min)
        for (index, element) in x.enumerated() {
            let t = originalDiff2(x: element) - y[index]
            if t > diff {
                diff = t
            }
        }
        
        return diff
    }
    
    func differenceForSecondRight(h: Double) -> Double {
        let temp = Diff().calculateDiff24(x0: -15, xK: 15, h: h)
        let y = temp.ys
        let x = temp.xs
        
        var diff: Double = Double(Int.min)
        
        for i in 0..<min(x.count, y.count) {
            let t = (originalDiff2(x: x[i]) - y[i])
            if t > diff {
                diff = t
            }
        }
        
        return diff
    }
    
    // MARK: - Вторая производная второго порядка
    func calculateDiff2Center(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        var xs = [Double]()
        for i in stride(from: x0, to: xK + h, by: h) {
            xs.append(i)
        }
        
        var ys = [Double]()
        for x in xs {
            ys.append(functionForDiff(x: x))
        }
        
        var F = [Double]()
        F.append((2*ys[0] - 5*ys[1] + 4*ys[2] - ys[3]) / (h * h))
        
        for i in 1..<ys.count - 1 {
            let t1 = (ys[i - 1] + ys[i + 1] - 2 * ys[i]) / (h * h)
            F.append(t1)
        }
        
        let n = ys.count
        let t3 = (2*ys[n-1] - 5*ys[n-2] + 4*ys[n-3] - ys[n-4]) / (h * h)
        F.append(t3)
        
        return (xs: xs, ys: F)
    }
    
    // MARK: - Вторая производная 4 порядка
    func calculateDiff24(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        var xs = [Double]()
        for i in stride(from: x0 - 2*h, to: xK + 2*h, by: h) {
            xs.append(i)
        }
        
        var ys = [Double]()
        for x in xs {
            ys.append(functionForDiff(x: x))
        }
        
        var F = [Double]()
        
        for i in 2..<ys.count - 2 {
            let t1 = (-ys[i-2] + 16 * ys[i-1] - 30 * ys[i] + 16 * ys[i+1] - ys[i+2]) / (12 * h * h)
            F.append(t1)
        }
        
        xs.removeFirst()
        xs.removeFirst()
        
        return (xs: xs, ys: F)
    }
}
