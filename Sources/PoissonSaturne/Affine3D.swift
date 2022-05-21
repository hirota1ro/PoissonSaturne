import Foundation

// member (row, col)
//
// | m11 m12 m13 tx |
// | m21 m22 m23 ty |
// | m31 m32 m33 tz |
// |   0   0   0  1 |

struct Affine3D {
    let m11: Double
    let m12: Double
    let m13: Double
    let tx: Double

    let m21: Double
    let m22: Double
    let m23: Double
    let ty: Double

    let m31: Double
    let m32: Double
    let m33: Double
    let tz: Double
}

extension Affine3D {

    static func * (a: Affine3D, p: Point3D) -> Point3D {
        let x = a.m11*p.x + a.m12*p.y + a.m13*p.z + a.tx
        let y = a.m21*p.x + a.m22*p.y + a.m23*p.z + a.ty
        let z = a.m31*p.x + a.m32*p.y + a.m33*p.z + a.tz
        return Point3D(x:x, y:y, z:z)
    }

    static func * (a: Affine3D, b: Affine3D) -> Affine3D {
        let n11 = a.m11*b.m11 + a.m12*b.m21 + a.m13*b.m31
        let n12 = a.m11*b.m12 + a.m12*b.m22 + a.m13*b.m32
        let n13 = a.m11*b.m13 + a.m12*b.m23 + a.m13*b.m33
        let ntx = a.m11*b.tx  + a.m12*b.ty  + a.m13*b.tz  + a.tx

        let n21 = a.m21*b.m11 + a.m22*b.m21 + a.m23*b.m31
        let n22 = a.m21*b.m12 + a.m22*b.m22 + a.m23*b.m32
        let n23 = a.m21*b.m13 + a.m22*b.m23 + a.m23*b.m33
        let nty = a.m21*b.tx  + a.m22*b.ty  + a.m23*b.tz  + a.ty

        let n31 = a.m31*b.m11 + a.m32*b.m21 + a.m33*b.m31
        let n32 = a.m31*b.m12 + a.m32*b.m22 + a.m33*b.m32
        let n33 = a.m31*b.m13 + a.m32*b.m23 + a.m33*b.m33
        let ntz = a.m31*b.tx  + a.m32*b.ty  + a.m33*b.tz  + a.tz

        return Affine3D(m11: n11, m12: n12, m13: n13, tx: ntx,
                        m21: n21, m22: n22, m23: n23, ty: nty,
                        m31: n31, m32: n32, m33: n33, tz: ntz)
    }
}

extension Affine3D {
    static let identity = Affine3D(m11: 1, m12: 0, m13: 0, tx: 0,
                                   m21: 0, m22: 1, m23: 0, ty: 0,
                                   m31: 0, m32: 0, m33: 1, tz: 0)
}

extension Affine3D {

    init(xRotationAngle t: Double) {
        let c = cos(t)
        let s = sin(t)
        self.init(m11: 1, m12: 0, m13: 0, tx: 0,
                  m21: 0, m22: c, m23:-s, ty: 0,
                  m31: 0, m32: s, m33: c, tz: 0)
    }

    init(yRotationAngle t: Double) {
        let c = cos(t)
        let s = sin(t)
        self.init(m11: c, m12: 0, m13: s, tx: 0,
                  m21: 0, m22: 1, m23: 0, ty: 0,
                  m31:-s, m32: 0, m33: c, tz: 0)
    }

    init(zRotationAngle t: Double) {
        let c = cos(t)
        let s = sin(t)
        self.init(m11: c, m12:-s, m13: 0, tx: 0,
                  m21: s, m22: c, m23: 0, ty: 0,
                  m31: 0, m32: 0, m33: 1, tz: 0)
    }

    init(scaleX x: Double, y: Double, z: Double) {
        self.init(m11: x, m12: 0, m13: 0, tx: 0,
                  m21: 0, m22: y, m23: 0, ty: 0,
                  m31: 0, m32: 0, m33: z, tz: 0)
    }

    init(translationX x: Double, y: Double, z: Double) {
        self.init(m11: 1, m12: 0, m13: 0, tx: x,
                  m21: 0, m22: 1, m23: 0, ty: y,
                  m31: 0, m32: 0, m33: 1, tz: z)
    }

}
