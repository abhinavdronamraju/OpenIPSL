within ThreePhase.MonoTri_Branches;

package MonoTriFcn
  function Inverse
    input Real[1, 18] I;
    output Real[1, 18] O;
  protected
    // Writing every element of the matrix to be inverted
    parameter Real a11 = I[1, 1];
    parameter Real b11 = I[1, 2];
    parameter Real a12 = I[1, 3];
    parameter Real b12 = I[1, 4];
    parameter Real a13 = I[1, 5];
    parameter Real b13 = I[1, 6];
    parameter Real a21 = I[1, 7];
    parameter Real b21 = I[1, 8];
    parameter Real a22 = I[1, 9];
    parameter Real b22 = I[1, 10];
    parameter Real a23 = I[1, 11];
    parameter Real b23 = I[1, 12];
    parameter Real a31 = I[1, 13];
    parameter Real b31 = I[1, 14];
    parameter Real a32 = I[1, 15];
    parameter Real b32 = I[1, 16];
    parameter Real a33 = I[1, 17];
    parameter Real b33 = I[1, 18];
    // Calculating the real and imaginary part of the matrix's determinant
    parameter Real A = a13 * a21 * a32 - a13 * b21 * b32 - b13 * a21 * b32 - b13 * b21 * a32 + a12 * a23 * a31 - a12 * b23 * b31 - b12 * a23 * b31 - b12 * b23 * a31 + a11 * a22 * a33 - a11 * b22 * b33 - b11 * a22 * b33 - b11 * b22 * a33 - (a33 * a21 * a12 - a33 * b21 * b12 - b33 * a21 * b12 - b33 * b21 * a12) - (a11 * a23 * a32 - a11 * b23 * b32 - b11 * a23 * b32 - b11 * b23 * a32) - (a13 * a22 * a31 - a13 * b22 * b31 - b13 * a22 * b31 - b13 * b22 * a31);
    parameter Real B = a13 * a21 * b32 + a13 * b21 * a32 + b13 * a21 * a32 - b13 * b21 * b32 + a12 * a23 * b31 + a12 * b23 * a31 + b12 * a23 * a31 - b12 * b23 * b31 + a11 * a22 * b33 + a11 * b22 * a33 + b11 * a22 * a33 - b11 * b22 * b33 - (a33 * a21 * b12 + a33 * b21 * a12 + b33 * a21 * a12 - b33 * b21 * b12) - (a11 * a23 * b32 + a11 * b23 * a32 + b11 * a23 * a32 - b11 * b23 * b32) - (a13 * a22 * b31 + a13 * b22 * a31 + b13 * a22 * a31 - b13 * b22 * b31);
    // Calculating the elements for the inverted matrix
    parameter Real r11 = (A * (a22 * a33 - a32 * a23 - b22 * b33 + b32 * b23) + B * (a22 * b33 + b22 * a33 - a32 * b23 - b32 * a23)) / (A * A + B * B);
    parameter Real x11 = (A * (a22 * b33 + b22 * a33 - a32 * b23 - b32 * a23) - B * (a22 * a33 - a32 * a23 - b22 * b33 + b32 * b23)) / (A * A + B * B);
    parameter Real r12 = (A * (a13 * a32 - a12 * a33 - b13 * b32 + b12 * b33) + B * (a13 * b32 + b13 * a32 - a12 * b33 - b12 * a33)) / (A * A + B * B);
    parameter Real x12 = (A * (a13 * b32 + b13 * a32 - a12 * b33 - b12 * a33) - B * (a13 * a32 - a12 * a33 - b13 * b32 + b12 * b33)) / (A * A + B * B);
    parameter Real r13 = (A * (a12 * a23 - a13 * a22 - b12 * b23 + b13 * b22) + B * (a12 * b23 + b12 * a23 - a13 * b22 - b13 * a22)) / (A * A + B * B);
    parameter Real x13 = (A * (a12 * b23 + b12 * a23 - a13 * b22 - b13 * a22) - B * (a12 * a23 - a13 * a22 - b12 * b23 + b13 * b22)) / (A * A + B * B);
    parameter Real r21 = (A * (a23 * a31 - a21 * a33 - b23 * b31 + b21 * b33) + B * (a23 * b31 + b23 * a31 - a21 * b33 - b21 * a33)) / (A * A + B * B);
    parameter Real x21 = (A * (a23 * b31 + b23 * a31 - a21 * b33 - b21 * a33) - B * (a23 * a31 - a21 * a33 - b23 * b31 + b21 * b33)) / (A * A + B * B);
    parameter Real r22 = (A * (a11 * a33 - a13 * a31 - b11 * b33 + b13 * b31) + B * (a11 * b33 + b11 * a33 - a13 * b31 - b13 * a31)) / (A * A + B * B);
    parameter Real x22 = (A * (a11 * b33 + b11 * a33 - a13 * b31 - b13 * a31) - B * (a11 * a33 - a13 * a31 - b11 * b33 + b13 * b31)) / (A * A + B * B);
    parameter Real r23 = (A * (a13 * a21 - a11 * a23 - b13 * b21 + b11 * b23) + B * (a13 * b21 + b13 * a21 - a11 * b23 - b11 * a23)) / (A * A + B * B);
    parameter Real x23 = (A * (a13 * b21 + b13 * a21 - a11 * b23 - b11 * a23) - B * (a13 * a21 - a11 * a23 - b13 * b21 + b11 * b23)) / (A * A + B * B);
    parameter Real r31 = (A * (a21 * a32 - a22 * a31 - b21 * b32 + b22 * b31) + B * (a21 * b32 + b21 * a32 - a22 * b31 - b22 * a31)) / (A * A + B * B);
    parameter Real x31 = (A * (a21 * b32 + b21 * a32 - a22 * b31 - b22 * a31) - B * (a21 * a32 - a22 * a31 - b21 * b32 + b22 * b31)) / (A * A + B * B);
    parameter Real r32 = (A * (a12 * a31 - a11 * a32 - b12 * b31 + b11 * b32) + B * (a12 * b31 + b12 * a31 - a11 * b32 - b11 * a32)) / (A * A + B * B);
    parameter Real x32 = (A * (a12 * b31 + b12 * a31 - a11 * b32 - b11 * a32) - B * (a12 * a31 - a11 * a32 - b12 * b31 + b11 * b32)) / (A * A + B * B);
    parameter Real r33 = (A * (a11 * a22 - a12 * a21 - b11 * b22 + b12 * b21) + B * (a11 * b22 + b11 * a22 - a12 * b21 - b12 * a21)) / (A * A + B * B);
    parameter Real x33 = (A * (a11 * b22 + b11 * a22 - a12 * b21 - b12 * a21) - B * (a11 * a22 - a12 * a21 - b11 * b22 + b12 * b21)) / (A * A + B * B);
  algorithm
    O := [r11, x11, r12, x12, r13, x13, r21, x21, r22, x22, r23, x23, r31, x31, r32, x32, r33, x33];
  end Inverse;

  function PositiveFilter
  input Real [1, 18] Z;
  output Real [1, 18] Y;
  
  protected
  // Getting data for the positive filter
  parameter Real g0 = 0;
  parameter Real b0 = 0;
  parameter Real g1 = 1;
  parameter Real b1 = 0;
  parameter Real g2 = 0;
  parameter Real b2 = 0;
  
  // Writing the positive filter matrix
  parameter Real c11 = (g0+g1+g2)/3;
  parameter Real d11 = (b0+b1+b2)/3;
  parameter Real c12 = (2*g0-g1-b1*sqrt(3)-g2+b2*sqrt(3))/6;
  parameter Real d12 = (2*b0+g1*sqrt(3)-b1-g2*sqrt(3)-b2)/6; 
  parameter Real c13 = (2*g0-g1+b1*sqrt(3)-g2-b2*sqrt(3))/6;
  parameter Real d13 = (2*b0-g1*sqrt(3)-b1+g2*sqrt(3)-b2)/6;
  parameter Real c21 = c13;
  parameter Real d21 = d13;
  parameter Real c22 = c11;
  parameter Real d22 = d11;
  parameter Real c23 = c12;
  parameter Real d23 = d12; 
  parameter Real c31 = c12;
  parameter Real d31 = d12;
  parameter Real c32 = c13;
  parameter Real d32 = d13;
  parameter Real c33 = c11;
  parameter Real d33 = d11;
  
  // Getting the elements of matrix Z (zii = rii +j*xii)
  parameter Real r11 = Z[1, 1];
  parameter Real x11 = Z[1, 2];
  parameter Real r12 = Z[1, 3];
  parameter Real x12 = Z[1, 4];
  parameter Real r13 = Z[1, 5];
  parameter Real x13 = Z[1, 6];
  parameter Real r21 = Z[1, 7];
  parameter Real x21 = Z[1, 8];
  parameter Real r22 = Z[1, 9];
  parameter Real x22 = Z[1, 10];
  parameter Real r23 = Z[1, 11];
  parameter Real x23 = Z[1, 12];
  parameter Real r31 = Z[1, 13];
  parameter Real x31 = Z[1, 14];
  parameter Real r32 = Z[1, 15];
  parameter Real x32 = Z[1, 16];
  parameter Real r33 = Z[1, 17];
  parameter Real x33 = Z[1, 18];
  
  // Getting the result for F*Z = Y (yii = gii + j*bii)
  parameter Real g11 = c11*r11 - d11*x11 + c12*r21 - d12*x21 + c13*r31 - d13*x31;
  parameter Real b11 = c11*x11 + d11*r11 + c12*x21 + d12*r21 + c13*x31 + d13*r31;
  parameter Real g12 = c11*r12 - d11*x12 + c12*r22 - d12*x22 + c13*r32 - d13*x32;
  parameter Real b12 = c11*x12 + d11*r12 + c12*x22 + d12*r22 + c13*x32 + d13*r32;
  parameter Real g13 = c11*r13 - d11*x13 + c12*r23 - d12*x23 + c13*r33 - d13*x33;
  parameter Real b13 = c11*x13 + d11*r13 + c12*x23 + d12*r23 + c13*x33 + d13*r33;
  parameter Real g21 = c21*r11 - d21*x11 + c22*r21 - d22*x21 + c23*r31 - d23*x31;
  parameter Real b21 = c21*x11 + d21*r11 + c22*x21 + d22*r21 + c23*x31 + d23*r31;
  parameter Real g22 = c21*r12 - d21*x12 + c22*r22 - d22*x22 + c23*r32 - d23*x32;
  parameter Real b22 = c21*x12 + d21*r12 + c22*x22 + d22*r22 + c23*x32 + d23*r32;
  parameter Real g23 = c21*r13 - d21*x13 + c22*r23 - d22*x23 + c23*r33 - d23*x33;
  parameter Real b23 = c21*x13 + d21*r13 + c22*x23 + d22*r23 + c23*x33 + d23*r33;
  parameter Real g31 = c31*r11 - d31*x11 + c32*r21 - d32*x21 + c33*r31 - d33*x31;
  parameter Real b31 = c31*x11 + d31*r11 + c32*x21 + d32*r21 + c33*x31 + d33*r31;
  parameter Real g32 = c31*r12 - d31*x12 + c32*r22 - d32*x22 + c33*r32 - d33*x32;
  parameter Real b32 = c31*x12 + d31*r12 + c32*x22 + d32*r22 + c33*x32 + d33*r32;
  parameter Real g33 = c31*r13 - d31*x13 + c32*r23 - d32*x23 + c33*r33 - d33*x33;
  parameter Real b33 = c31*x13 + d31*r13 + c32*x23 + d32*r23 + c33*x33 + d33*r33;
  
  algorithm
  // The output value receive the filtered value
   Y := [g11, b11, g12, b12, g13, b13,g21, b21, g22, b22, g23, b23,g31, b31, g32, b32, g33, b33];
   
  end PositiveFilter;

  function NegZerFilter
  input Real [1, 18] Z;
  output Real [1, 18] Y;
  
  protected
  // Getting data for the positive filter
  parameter Real g0 = 1;
  parameter Real b0 = 0;
  parameter Real g1 = 0;
  parameter Real b1 = 0;
  parameter Real g2 = 1;
  parameter Real b2 = 0;
  
  // Writing the positive filter matrix
  parameter Real c11 = (g0+g1+g2)/3;
  parameter Real d11 = (b0+b1+b2)/3;
  parameter Real c12 = (2*g0-g1-b1*sqrt(3)-g2+b2*sqrt(3))/6;
  parameter Real d12 = (2*b0+g1*sqrt(3)-b1-g2*sqrt(3)-b2)/6; 
  parameter Real c13 = (2*g0-g1+b1*sqrt(3)-g2-b2*sqrt(3))/6;
  parameter Real d13 = (2*b0-g1*sqrt(3)-b1+g2*sqrt(3)-b2)/6;
  parameter Real c21 = c13;
  parameter Real d21 = d13;
  parameter Real c22 = c11;
  parameter Real d22 = d11;
  parameter Real c23 = c12;
  parameter Real d23 = d12; 
  parameter Real c31 = c12;
  parameter Real d31 = d12;
  parameter Real c32 = c13;
  parameter Real d32 = d13;
  parameter Real c33 = c11;
  parameter Real d33 = d11;
  
  // Getting the elements of matrix Z (zii = rii +j*xii)
  parameter Real r11 = Z[1, 1];
  parameter Real x11 = Z[1, 2];
  parameter Real r12 = Z[1, 3];
  parameter Real x12 = Z[1, 4];
  parameter Real r13 = Z[1, 5];
  parameter Real x13 = Z[1, 6];
  parameter Real r21 = Z[1, 7];
  parameter Real x21 = Z[1, 8];
  parameter Real r22 = Z[1, 9];
  parameter Real x22 = Z[1, 10];
  parameter Real r23 = Z[1, 11];
  parameter Real x23 = Z[1, 12];
  parameter Real r31 = Z[1, 13];
  parameter Real x31 = Z[1, 14];
  parameter Real r32 = Z[1, 15];
  parameter Real x32 = Z[1, 16];
  parameter Real r33 = Z[1, 17];
  parameter Real x33 = Z[1, 18];
  
  // Getting the result for F*Z = Y (yii = gii + j*bii)
  parameter Real g11 = c11*r11 - d11*x11 + c12*r21 - d12*x21 + c13*r31 - d13*x31;
  parameter Real b11 = c11*x11 + d11*r11 + c12*x21 + d12*r21 + c13*x31 + d13*r31;
  parameter Real g12 = c11*r12 - d11*x12 + c12*r22 - d12*x22 + c13*r32 - d13*x32;
  parameter Real b12 = c11*x12 + d11*r12 + c12*x22 + d12*r22 + c13*x32 + d13*r32;
  parameter Real g13 = c11*r13 - d11*x13 + c12*r23 - d12*x23 + c13*r33 - d13*x33;
  parameter Real b13 = c11*x13 + d11*r13 + c12*x23 + d12*r23 + c13*x33 + d13*r33;
  parameter Real g21 = c21*r11 - d21*x11 + c22*r21 - d22*x21 + c23*r31 - d23*x31;
  parameter Real b21 = c21*x11 + d21*r11 + c22*x21 + d22*r21 + c23*x31 + d23*r31;
  parameter Real g22 = c21*r12 - d21*x12 + c22*r22 - d22*x22 + c23*r32 - d23*x32;
  parameter Real b22 = c21*x12 + d21*r12 + c22*x22 + d22*r22 + c23*x32 + d23*r32;
  parameter Real g23 = c21*r13 - d21*x13 + c22*r23 - d22*x23 + c23*r33 - d23*x33;
  parameter Real b23 = c21*x13 + d21*r13 + c22*x23 + d22*r23 + c23*x33 + d23*r33;
  parameter Real g31 = c31*r11 - d31*x11 + c32*r21 - d32*x21 + c33*r31 - d33*x31;
  parameter Real b31 = c31*x11 + d31*r11 + c32*x21 + d32*r21 + c33*x31 + d33*r31;
  parameter Real g32 = c31*r12 - d31*x12 + c32*r22 - d32*x22 + c33*r32 - d33*x32;
  parameter Real b32 = c31*x12 + d31*r12 + c32*x22 + d32*r22 + c33*x32 + d33*r32;
  parameter Real g33 = c31*r13 - d31*x13 + c32*r23 - d32*x23 + c33*r33 - d33*x33;
  parameter Real b33 = c31*x13 + d31*r13 + c32*x23 + d32*r23 + c33*x33 + d33*r33;
  
  algorithm
  // The output value receive the filtered value
   Y := [g11, b11, g12, b12, g13, b13,g21, b21, g22, b22, g23, b23,g31, b31, g32, b32, g33, b33];
   
  end NegZerFilter;
end MonoTriFcn;
