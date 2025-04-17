# MongoDB Projection Overview

We can retrieve documents with only the required fields instead of all fields. This process is called **projection**.

In MongoDB, **projection** is the concept of specifying which fields from documents in a collection should be included or excluded when performing a query. This is similar to selecting specific columns in SQL databases.

## SQL vs MongoDB Projection

- **SQL:**
  - Without projection: 
    ```sql
    SELECT * FROM employees;
    ```
  - With projection: 
    ```sql
    SELECT ename, esal FROM employees;
    ```

- **MongoDB:**
  - Without projection: 
    ```javascript
    db.collection.find({filter});
    ```
  - With projection: 
    ```javascript
    db.collection.find({filter}, {projection fields});
    ```

**Note:** You must include at least an empty filter object `{}` to use projection fields.

---

## MongoDB Query Examples

1. **Project only `title` and `no_of_reviews`:**
    ```javascript
    db.books.find({}, {title: 1, no_of_reviews: 1}).pretty()
    ```

    **Output (truncated):**
    ```json
    [
      {
        "_id": ObjectId("66c49da6b033c154dd47d271"),
        "title": "Web Development Essentials",
        "no_of_reviews": 40
      },
      ...
    ]
    ```

2. **Project only `title` and `no_of_reviews` without `_id`:**
    ```javascript
    db.books.find({}, {title: 1, no_of_reviews: 1, _id: 0}).pretty()
    ```

    **Output (truncated):**
    ```json
    [
      {
        "title": "Web Development Essentials",
        "no_of_reviews": 40
      },
      ...
    ]
    ```

3. **Select documents where `no_of_reviews >= 3` and project `title`, `no_of_reviews`, and `isbn`:**
    ```javascript
    db.books.find({ no_of_reviews: { $gte: 3 } }, { title: 1, no_of_reviews: 1, isbn: 1, _id: 0 }).pretty()
    ```

    **Output (truncated):**
    ```json
    [
      {
        "title": "Web Development Essentials",
        "isbn": 8910,
        "no_of_reviews": 40
      },
      ...
    ]
    ```

4. **Project nested document fields: `title`, `author.name`, and `author.profile.books`:**
    ```javascript
    db.books.find({}, { title: 1, "author.name": 1, "author.profile.books": 1, _id: 0 }).pretty()
    ```

    **Output (truncated):**
    ```json
    [
      {
        "title": "Web Development Essentials",
        "author": {
          "name": "Sara Lee",
          "profile": {
            "books": 2
          }
        }
      },
      ...
    ]
    ```

---

## Projection for Array Fields

- **Project all documents with the tag "programming" and show only `title` and `tags`:**
    ```javascript
    db.books.find({tags: "programming"}, {title: 1, tags: 1, _id: 0}).pretty()
    ```

    **Output:**
    ```json
    [
      {
        "title": "Mastering Python",
        "tags": ["python", "programming", "scripting"]
      },
      ...
    ]
    ```

- **Use `$` to project only the matched element from the `tags` array:**
    ```javascript
    db.books.find({tags: "programming"}, {title: 1, "tags.$": 1, _id: 0}).pretty()
    ```

    **Output:**
    ```json
    [
      {
        "title": "Mastering Python",
        "tags": ["programming"]
      },
      ...
    ]
    ```

---

## Key Notes

- `1` indicates inclusion of a field.
- `0` indicates exclusion of a field.
- The `_id` field is included by default but can be explicitly excluded by setting it to `0`.

---


