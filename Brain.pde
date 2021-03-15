public class Brain {

  public PVector pickDirection(Obstacle o) {
    return new PVector(1, 1);
  }

  public float[][] multiplyMatrices(float[][] A, float[][] B) {
    if (A[0].length != B.length)
      return null;
    float[][] C = new float[A.length][B[0].length];
    for (int i = 0; i < A.length; i++) {      
      for (int j = 0; j < B[0].length; j++) {
        float[] arr = new float[B.length];
        for (int k = 0; k < A[0].length; k++) {
          arr[k] = A[i][k] * B[k][j];
        }
        C[i][j] = sumArray(arr);
      }
    }
    return C;
  }

  public float[][] addMatrices(float[][] A, float[][] B) {
    if (A.length != B.length || A[0].length != B[0].length)
      return null;
    float[][] C = new float[A.length][A[0].length];
    for (int i = 0; i < A.length; i++) {
      for (int j = 0; j < A[0].length; j++) {
        C[i][j] = A[i][j] + B[i][j];
      }
    }
    return C;
  }

  public float sumArray(float[] arr) {
    float sum = 0;  
    for (int i = 0; i < arr.length; i++) {
      sum += arr[i];
    }
    return sum;
  }
}
