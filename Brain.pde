public class Brain { //<>//
  float[][] input, hidden, output, w_ih, b_h, w_ho, b_o;
  int inputNodes = 2, hiddenNodes = 3, outputNodes = 2;
  Rocket r;

  public Brain(Rocket r) {
    this.r = r;
    w_ih = new float[inputNodes][hiddenNodes];
    w_ih = randomize(w_ih);
    b_h = new float[1][hiddenNodes];
    b_h = randomize(b_h);
    w_ho = new float[hiddenNodes][outputNodes];
    w_ho = randomize(w_ho);
    b_o = new float[1][outputNodes];
    b_o = randomize(b_o);
  }
  
  public Brain(Rocket r, Brain b) {
    this.r = r;
    w_ih = new float[inputNodes][hiddenNodes];
    w_ih = replicate(b.w_ih);
    b_h = new float[1][hiddenNodes];
    b_h = replicate(b.b_h);
    w_ho = new float[hiddenNodes][outputNodes];
    w_ho = replicate(b.w_ho);
    b_o = new float[1][outputNodes];
    b_o = replicate(b.b_o);
    mutate();
  }
  
  private float[][] replicate(float[][] mat) {
    float[][] newMat = new float[mat.length][mat[0].length];
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat[0].length; j++) {
        newMat[i][j] = mat[i][j]; 
      }
    }
    return newMat;
  }
  
  public void mutate() {
    mutateMatrix(w_ih);
    mutateMatrix(b_h);
    mutateMatrix(w_ho);
    mutateMatrix(b_o);
  }

  public void mutateMatrix(float[][] mat) {
    //loop through all values in matrix 
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat[0].length; j++) {
        //pick random number         
        //if random is certain level
        if (Math.random() < 0.2) {
          //pick another random change amount
          //change the value in the matrix
          mat[i][j] *= Math.random() * 4 - 2;
        }
      }
    }
  }

  public float[][] randomize(float[][] mat) {
    float[][] randMat = new float[mat.length][mat[0].length];
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat[0].length; j++) {
        randMat[i][j] = random(-10, 10);
      }
    }
    return randMat;
  }

  public PVector pickDirection(Obstacle o) {
    PVector diff = PVector.sub(r.pos, o.pos);
    input = new float[1][inputNodes];
    input[0][0] = diff.x;
    input[0][1] = diff.y;
    hidden = multiplyMatrices(input, w_ih);
    hidden = addMatrices(b_h, hidden);
    hidden = applyActivation(hidden);
    output = multiplyMatrices(hidden, w_ho);
    output = addMatrices(b_o, output);
    output = applyActivation(output);
    return new PVector(output[0][0], output[0][1]);
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
    return 2.0 / (1 + exp(-x)) - 1;
  }

  public float[][] multiplyMatrices(float[][] A, float[][] B) {
    if (A[0].length != B.length) {
      //throw new Exception("Matrix wrong shape.");
      return null;
    }
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
