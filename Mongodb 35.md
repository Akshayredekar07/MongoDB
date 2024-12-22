

## Assignment: 

### quizdata.csv

### To import data from csv file:
```bash
mongoimport --db quizdb --collection quiz --type csv --headerline --file quizdata.csv
```

#### Sample Data:
```json
{ _id: 2, name: 'TeamB', round: 1, points: 3, city: 'Bangalore' },
{ _id: 6, name: 'TeamB', round: 2, points: 10, city: 'Bangalore' },
{ _id: 7, name: 'TeamC', round: 2, points: 3, city: 'Chennai' },
{ _id: 8, name: 'TeamD', round: 2, points: 7, city: 'Hyderabad' },
{ _id: 9, name: 'TeamA', round: 3, points: 10, city: 'Hyderabad' },
{ _id: 10, name: 'TeamB', round: 3, points: 4, city: 'Bangalore' },
{ _id: 5, name: 'TeamA', round: 2, points: 5, city: 'Hyderabad' },
{ _id: 11, name: 'TeamC', round: 3, points: 1, city: 'Chennai' },
{ _id: 12, name: 'TeamD', round: 3, points: 5, city: 'Hyderabad' },
{ _id: 1, name: 'TeamA', round: 1, points: 5, city: 'Hyderabad' },
{ _id: 13, name: 'TeamA', round: 4, points: 8, city: 'Hyderabad' },
{ _id: 14, name: 'TeamB', round: 4, points: 7, city: 'Bangalore' },
{ _id: 15, name: 'TeamC', round: 4, points: 7, city: 'Chennai' },
{ _id: 16, name: 'TeamD', round: 4, points: 9, city: 'Hyderabad' },
{ _id: 3, name: 'TeamC', round: 1, points: 4, city: 'Chennai' },
{ _id: 4, name: 'TeamD', round: 1, points: 5, city: 'Hyderabad' }
```

---

### Q1. To find TeamA's total number of points in all 4 rounds?
```javascript
db.quiz.aggregate([
    { $match: { name: "TeamA" } },
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } }
]);
```

Output:
```json
[ { _id: 'TeamA', totalScore: 28 } ]
```

---

### Q2. To find the average score of TeamA per round?
```javascript
db.quiz.aggregate([
    { $match: { name: "TeamA" } },
    { $group: { _id: "$name", avgScore: { $avg: "$points" } } },
    { $project: { _id: 0, avgScore: 1 } }
]);
```

Output:
```json
[ { avgScore: 7 } ]
```

---

### Q3. To find the total score of Hyderabad Teams?
```javascript
db.quiz.aggregate([
    { $match: { city: "Hyderabad" } },
    { $group: { _id: null, totalScore: { $sum: "$points" } } },
    { $project: { _id: 0, totalScore: 1 } }
]);
```

Output:
```json
[ { totalScore: 54 } ]
```

---

### Q4. To find the winner team's name?
- Teamwise total score
- Sort in descending order based on total score
- Limit to 1 to display the winner team's name
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: -1 } },
    { $limit: 1 }
]);
```

Output:
```json
[ { _id: 'TeamA', totalScore: 28 } ]
```

---

### Q5. To find the 2nd position team's name (Runner-up)?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: -1 } },
    { $skip: 1 },
    { $limit: 1 }
]);
```

Output:
```json
[ { _id: 'TeamD', totalScore: 26 } ]
```

---

### Q6. To find the team with the least score?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: 1 } },
    { $limit: 1 }
]);
```

Output:
```json
[ { _id: 'TeamC', totalScore: 15 } ]
```

---

### Q7. To find the total points of the winning team?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: -1 } },
    { $limit: 1 },
    { $project: { _id: 0, totalScore: 1 } }
]);
```

Output:
```json
[ { totalScore: 28 } ]
```

---

### Q8. To find the teamwise score?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { name: 1 } }
]);
```

Output:
```json
{ _id: 'TeamC', totalScore: 15 },
{ _id: 'TeamD', totalScore: 26 },
{ _id: 'TeamB', totalScore: 24 },
{ _id: 'TeamA', totalScore: 28 }
```

---

### Q9. Show only the winning team and city?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", city: { $first: "$city" }, totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: -1 } },
    { $limit: 1 },
    { $project: { _id: 0, name: "$_id", totalScore: 1, city: 1 } }
]);
```

Output:
```json
[ { city: 'Hyderabad', totalScore: 28, name: 'TeamA' } ]
```

---

### Q10. To find teamwise average score in ascending order?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", avgScore: { $avg: "$points" } } },
    { $sort: { avgScore: 1 } }
]);
```

---

### Q11. To find teamwise total score in descending order?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", totalScore: { $sum: "$points" } } },
    { $sort: { totalScore: -1 } }
]);
```

---

### Q12. To find teamwise total score and arrange alphabetically by city name, if two cities are the same, arrange by ascending score, and write to `citywisetotal` collection?
```javascript
db.quiz.aggregate([
    { $group: { _id: "$name", city: { $first: "$city" }, totalScore: { $sum: "$points" } } },
    { $sort: { city: 1, totalScore: 1 } },
    { $out: "citywisetotal" }
]);
```

Output:
```json
[ 
  { _id: 'TeamB', city: 'Bangalore', totalScore: 24 },
  { _id: 'TeamC', city: 'Chennai', totalScore: 15 },
  { _id: 'TeamD', city: 'Hyderabad', totalScore: 26 },
  { _id: 'TeamA', city: 'Hyderabad', totalScore: 28 }
]
```

---

### Additional Notes:
1. Within the same pipeline, we can use the same stage multiple times.
2. Example after first and second group stages:
```json
First Group Stage:
[
  { _id: 'TeamD', city: 'Hyderabad', totalScore: 26 },
  { _id: 'TeamA', city: 'Hyderabad', totalScore: 28 },
  { _id: 'TeamB', city: 'Bangalore', totalScore: 24 },
  { _id: 'TeamC', city: 'Chennai', totalScore: 15 }
]

Second Group Stage:
[
  { _id: 'Hyderabad', cityWiseScore: 54 },
  { _id: 'Bangalore', cityWiseScore: 24 },
  { _id: 'Chennai', cityWiseScore: 15 }
]
```
