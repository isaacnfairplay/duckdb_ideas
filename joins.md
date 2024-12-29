# Guide to Performing Joins in DuckDB

DuckDB provides a rich set of functionalities to perform joins between tables or relations. This guide explains the various types of joins with examples, including the use of the `USING` clause for multi-column joins.

## Setting Up
Before performing joins, we need to create a DuckDB connection and define the data we want to work with. Here, we use `SELECT` statements with `UNION ALL` to structure the data.

```python
import duckdb

# Create an in-memory DuckDB database
con = duckdb.connect()

# Define relations
rel1 = con.query(
    """
    SELECT 1 AS id, 'A' AS value, '2023-01-01' AS date UNION ALL
    SELECT 2, 'B', '2023-01-02' UNION ALL
    SELECT 3, 'C', '2023-01-03'
    """
)
rel2 = con.query(
    """
    SELECT 1 AS id, 'X' AS value, '2023-01-01' AS date UNION ALL
    SELECT 2, 'Y', '2023-01-02' UNION ALL
    SELECT 4, 'Z', '2023-01-04'
    """
)
```

## Types of Joins

### 1. Inner Join
An inner join returns rows that have matching values in both relations. It supports multi-column joins by specifying columns separated by commas.

```python
inner_join_result = rel1.join(rel2, "id, date", how='inner')
print("Inner Join Result:")
print(inner_join_result)
```

**Output:**
Only rows with matching `id` and `date` values in both `rel1` and `rel2` are returned.

### 2. Left Join
A left join returns all rows from the left relation and the matched rows from the right relation. If no match is found, NULLs are returned for columns from the right relation.

```python
left_join_result = rel1.join(rel2, "id, date", how='left')
print("\nLeft Join Result:")
print(left_join_result)
```

**Output:**
All rows from `rel1` are included, with matching rows from `rel2` or NULLs if no match exists.

### 3. Right Join
A right join returns all rows from the right relation and the matched rows from the left relation. If no match is found, NULLs are returned for columns from the left relation.

```python
right_join_result = rel1.join(rel2, "id, date", how='right')
print("\nRight Join Result:")
print(right_join_result)
```

**Output:**
All rows from `rel2` are included, with matching rows from `rel1` or NULLs if no match exists.

### 4. Full Outer Join
A full outer join returns all rows when there is a match in either relation. Rows that do not have a match in one relation will have NULLs in the columns from the other relation.

```python
full_outer_join_result = rel1.join(rel2, "id, date", how='outer')
print("\nFull Outer Join Result:")
print(full_outer_join_result)
```

**Output:**
All rows from both `rel1` and `rel2` are included, with NULLs where no match exists.

### 5. Cross Join
A cross join produces a Cartesian product of the two relations, returning all possible combinations of rows from both relations.

```python
cross_join_result = rel1.join(rel2, "TRUE")
print("\nCross Join Result:")
print(cross_join_result)
```

**Output:**
Every row from `rel1` is combined with every row from `rel2`.

### 6. Anti Join
An anti join returns rows from the left relation that do not have a match in the right relation.

```python
anti_join_result = rel1.join(rel2.select('id', 'date'), "id, date", how='anti')
print("\nAnti Join Result:")
print(anti_join_result)
```

**Output:**
Only rows from `rel1` without a matching `id` and `date` in `rel2` are included.

### 7. Semi Join
A semi join returns rows from the left relation that have a match in the right relation. Unlike an inner join, it does not include columns from the right relation.

```python
semi_join_result = rel1.join(rel2.select('id', 'date'), "id, date", how='inner')
print("\nSemi Join Result:")
print(semi_join_result)
```

**Output:**
Only rows from `rel1` with a matching `id` and `date` in `rel2` are included.

## Summary
DuckDB provides versatile join operations that can handle various data relationship requirements. By specifying columns in the join condition using `id, date` or other multi-column combinations, you can efficiently query and combine data across multiple relations. This guide demonstrates how to set up and execute each join type, ensuring you can effectively manage your data transformations.

