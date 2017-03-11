# An implementation of n-grams k-skips algorithm in Haskell

### Usage
  - Generate all n-grams from a finite list, with padding (padded token = -1)
  ```haskell
  *Main> rollSkipgrams [1..5] 3 2  -- 3-grams with 2-skips
  [[1,2,3],[1,2,4],[1,2,5],[1,3,4],[1,3,5],[1,4,5],[2,3,4],[2,3,5],[2,3,-1],[2,4,5],[2,4,-1],[2,5,-1],[3,4,5],[3,4,-1],[3,4,-1],[3,5,-1],[3,5,-1],[3,-1,-1],[4,5,-1],[4,5,-1],[4,5,-1],[4,-1,-1],[4,-1,-1],[4,-1,-1],[5,-1,-1],[5,-1,-1],[5,-1,-1],[5,-1,-1],[5,-1,-1],[5,-1,-1]]
  ```
   
  - Generate all valid n-grams from a finite list
  ```haskell
  *Main> validSkipgrams [1..10] 3 2
  [[1,2,3],[1,2,4],[1,2,5],[1,3,4],[1,3,5],[1,4,5],[2,3,4],[2,3,5],[2,4,5],[3,4,5]]
  ```
  



