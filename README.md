# Generate skipgrams (recursively) in Haskell

### Usage
  - Generate all n-grams with k-skips from a finite list, with padding (padded token = -1) 
  ```haskell
  *Main> rollSkipgrams [1..3] 3 2  -- 3-grams with 2-skips
  [[1,2,3],[1,2,-1],[1,2,-1],[1,3,-1],[1,3,-1],[1,-1,-1],[2,3,-1],[2,3,-1],[2,3,-1],[2,-1,-1],[2,-1,-1],[2,-1,-1],[3,-1,-1],[3,-1,-1],[3,-1,-1],[3,-1,-1],[3,-1,-1],[3,-1,-1]]

  ```
   
  - Generate all valid n-grams with k-skips from a finite list
  ```haskell
  *Main> validSkipgrams [1..3] 3 2
  [[1,2,3]]
  
  ```

