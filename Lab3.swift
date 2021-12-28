import Foundation

func integralFunc(x: Double) -> Double {
    return sin(x)*sin(x)*sin(x)*sin(x)
}

func calculateIntegralSimpson(
    n: Int,
    minValue: Double,
    maxValue: Double
) -> (first: (xPoints: [Double], yPoints: [Double]),
      second: (xPoints: [Double], yPoints: [Double]),
      difference: Double)
{
    var basePoints = [Double]()
    let distance: Double = (maxValue - minValue)/Double(n)
    var x: Double = minValue

    for _ in 0..<n {
        basePoints.append(x)
        x += distance
    }

    // MARK: - Метод Симпсона
    var result: Double = distance*(integralFunc(x: minValue) + integralFunc(x: maxValue))/6
    for i in 0..<basePoints.count {
        result += (4/6)*distance*integralFunc(x: minValue + distance*(Double(i) - 0.5))
    }
    for i in 0..<basePoints.count - 1 {
        result += (2/6)*distance*integralFunc(x: minValue + distance*Double(i))
    }

    var baseYPoints = [Double]()
    for i in basePoints {
        baseYPoints.append(integralFunc(x: i))
    }
    
    
    let diff = 2.356171941724436 - result
    return ((basePoints, baseYPoints) , ([], []), diff)
}


func calculateIntegralTrapezii(
    n: Int,
    minValue: Double,
    maxValue: Double
) -> Double
{
    var basePoints = [Double]()
    let distance: Double = (maxValue - minValue)/Double(n)
    var x: Double = minValue

    for _ in 0..<n {
        basePoints.append(x)
        x += distance
    }

    // MARK: - Метод трапеций
    var result: Double = distance*(integralFunc(x: minValue) + integralFunc(x: maxValue))/2
    for i in 0..<basePoints.count {
        result += distance*integralFunc(x: minValue + distance*Double(i))
    }
    
    var baseYPoints = [Double]()
    for i in basePoints {
        baseYPoints.append(integralFunc(x: i))
    }
    
    let diff = 2.356171941724436 - result
    return diff
}

func calculateIntegralRectangle(
    n: Int,
    minValue: Double,
    maxValue: Double
) -> (first: (xPoints: [Double], yPoints: [Double]),
      second: (xPoints: [Double], yPoints: [Double]),
      difference: Double)
{
    var basePoints = [Double]()
    let distance: Double = (maxValue - minValue)/Double(n)
    var x: Double = minValue

    for _ in 0..<n {
        basePoints.append(x)
        x += distance
    }
    
    var result: Double = 0
    for i in 0..<basePoints.count - 1 {
        result += distance*(integralFunc(x: minValue + distance*Double(Double(i) - 0.5)))
    }
    
    var baseYPoints = [Double]()
    for i in basePoints {
        baseYPoints.append(integralFunc(x: i))
    }

    let diff = 2.356171941724436 - result
    return ((basePoints, baseYPoints) , ([], []), diff)
}

func Gauss2(N: Int) -> Double {
    let a: Double = -3
    let b: Double = 3
    var s: Double = 0
    
    for i in 0...N {
        let test = (b-a)/Double(N)
        let tempA = a + Double(i)*test
        let tempB = a + Double(i+1)*test
        s += Gauss2(a: tempA, b: tempB)
    }
    
    let diff = 2.356171941724436 - s
    return diff
}

fileprivate func Gauss2(a: Double, b: Double) -> Double {
    //MARK: Для двух точек
    let Xi = [-0.5773503, 0.5773503]
    let Ci: [Double] = [1, 1]
    
    let ra = (b - a)/2
    let su = (a + b)/2
    
    var Q: Double = 0
    var S: Double = 0
    
    for i in 0..<Xi.count {
        Q = su + ra*Xi[i]
        S += Ci[i]*integralFunc(x: Q)
    }
    
    return ra*S
}

func Gauss3(N: Int) -> Double {
    let a: Double = -3
    let b: Double = 3
    var s: Double = 0
    
    for i in 0...N {
        let test = (b-a)/Double(N)
        let tempA = a + Double(i)*test
        let tempB = a + Double(i+1)*test
        s += Gauss3(a: tempA, b: tempB)
    }
    
    let diff = 2.356171941724436 - s
    return diff
}

fileprivate func Gauss3(a: Double, b: Double) -> Double {
    
    //MARK: Для трех точек
    let Xi = [-0.7745967, 0, 0.7745967]
    let Ci = [0.5555556,0.8888889,0.5555556]
    
    let ra = (b - a)/2
    let su = (a + b)/2
    
    var Q: Double = 0
    var S: Double = 0
    
    for i in 0..<Xi.count {
        Q = su + ra*Xi[i]
        S += Ci[i]*integralFunc(x: Q)
    }
    
    return ra*S
}
