# Lab 03: Git in Depth, Report

## 1. Object hashes from Section 4.4

These are from my first commit, taken from my own repository.

- **Root tree:** `<root-tree-hash>`. This is the snapshot of the whole top-level folder, listing `.gitignore`, `Makefile` and the `src` folder.
- **src tree:** `<src-tree-hash>`. This is the tree object for the `src` directory, listing the three input text files.
- **services.txt blob:** `<services-blob-hash>`. This is the raw contents of `src/services.txt` (the three service names), stored with no filename attached.

## 2. git log --oneline --graph (main)# Lab 03: Git in Depth, Report

## 1. Object hashes from Section 4.4

These are from my first commit, taken from my own repository.

- **Root tree:** `<root-tree-hash>`. This is the snapshot of the whole top-level folder, listing `.gitignore`, `Makefile` and the `src` folder.
- **src tree:** `<src-tree-hash>`. This is the tree object for the `src` directory, listing the three input text files.
- **services.txt blob:** `<services-blob-hash>`. This is the raw contents of `src/services.txt` (the three service names), stored with no filename attached.

## 2. git log --oneline --graph (main)


## 3. Why the hash changed in Section 7.3

I did not change any files, but the hash still changed after `git rebase main`. A commit's hash is calculated from everything inside it, and that includes the parent commit. Rebasing moved my commit so that it sits on top of the new tip of main (the README commit) instead of its old parent. With a different parent, the content being hashed is different, so Git created a brand new commit object with a new name. The old commit still exists in the database, but nothing points to it anymore.

## 4. The merge conflict in Task 3

On `main` I added a `count` target that prints the number of source files (`ls | wc -l`). On `feature/word-count` I added a `count` target in the same place that prints the total word count of the built files (`wc -w`). Both edited the same lines, so Git could not decide which one to keep and stopped with a conflict. I did not just pick one side, because both behaviours are useful. I replaced the marked region with a single `count` target that prints the source file count and then the word count. That is why my result is neither side verbatim. I made sure no conflict markers were left, ran `make count` to check it worked, and then committed the merge.

## 5. Task 5: bisect

The first bad commit was `2d389cb` ("Speed up the transform step"). It replaced the correct `tr` pipeline in `transform.sh` with one that first deleted the last line of the input, so one line went missing. Bisect needed only four tests for sixteen commits because it does a binary search: each test checks the middle commit and throws away half of the remaining candidates, and halving 16 repeatedly (16, 8, 4, 2, 1) takes about log2(16) = 4 steps.

## 6. Fallback Makefile

I did not use the provided `fallback/` folder. I used my own Makefile and `src/` files from Lab 02.
