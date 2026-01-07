# Problem Statement

Given a string `s` of length `N` consisting of the characters:  
`( ) [ ] { } ?`

Each character `?` may be replaced with any one of the six bracket characters.

## Task

Count the number of different correct bracket sequences that can be obtained after replacing every `?` by brackets.

**Note:** for empty string `s` the empty sequence is already correct bracket sequence, so answer is 1.

## Input Format

- `N` – an even integer, the length of the string  
- `s` – the string itself

## Output Format

- One integer – the number of valid sequences **modulo** $10^9+7$

## Constraints

- $N \ge 0$

## Examples

### Example 1
**Input**
```
2
??
```
**Output**
```
3
```

### Example 2
**Input**
```
4
(?)?
```
**Output**
```
1
```

### Example 3
**Input**
```
4
????
```
**Output**
```
18
```
