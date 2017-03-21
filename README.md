# Random-Crap
Random assortment of small programs

setOptimizer
Takes a number of arrays (organized in columns) and separates the ones that are always together into separate groups.

Input:
| Group1 | Group2 | Group3 | Group4 | Group5 |
|--------|--------|--------|--------|--------|
| Item1  | Item1  | Item1  | Item2  | Item4  |
| Item2  | Item2  | Item3  |        |        |
| Item3  | Item3  |        |        |        |

This will get sorted into:
- ITEM1, ITEM3
- ITEM2
- ITEM4
