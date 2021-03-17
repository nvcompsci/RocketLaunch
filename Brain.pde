public class Brain {
  float[][] input, hidden, output, w_ih, b_h, w_ho, b_o;
  int inputNodes = 2, hiddenNodes = 3, outputNodes = 2;
  
  public Brain() {
    w_ih = new float[inputNodes][hiddenNodes];
    w_ih = randomize(w_ih);
    b_h = new float[1][hiddenNodes];
    b_h = randomize(b_h);
    w_ho = new float[outputNodes][hiddenNodes];
    w_ho = randomize(w_ho);
    b_o = new float[1][outputNodes];
    b_o = randomize(b_o);
  }
  
  public float[][] randomize(float[][] mat) {
    float[][] randMat = new float[mat.length][mat[0].length];
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat[0].length; j++) {
        randMat[i][j] = random(-10,10);
      }
    }
    return randMat;
  }
  
  public float[] pickDirection(Obstacle o) {
    hidden = multiplyMatrices(input, w_ih);
    hidden = addMatrices(b_h, hidden);
    hidden = applyActivation(hidden);
    output = multiplyMatrices(hidden, w_ho);
    output = addMatrices(b_o, output);
    output = applyActivation(output);
    return output[0];
  }
  
  public float[][] applyActivation(float[][] mat) {
    float[][] activated = new float[mat.length][mat[0].length];
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat[0].length; j++) {
        activated[i][j] = sigmoid(mat[i][j]); 
      }
    }
    return activated;
  }
  
  public float sigmoid(float x) {
    return 1.0 / (1 + exp(-x)); 
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
