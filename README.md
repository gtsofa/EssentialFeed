# Building a Swift App with TDD and Modular Design

[![CI](https://github.com/gtsofa/EssentialFeed/actions/workflows/CI.yml/badge.svg)](https://github.com/gtsofa/EssentialFeed/actions/workflows/CI.yml)

1. System delivers error.

#### Empty cache course (sad path):
1. System delivers not found error.

---

### Validate Feed Cache Use Case

### Primary course:
1. Execute "Validate Cache" command with above data.
2. System retrieves feed data from cache.
3. System validates cache is less than seven days old.

### Retrieval error course ( sad path):
1. System deletes cache.

### Expired cache course (sad path):
1. System deletes cache.

---

### Cache Feed Use Case

#### Data:
- Image Feed

#### Primary course (happy path):
1. Execute "Save Image Feed" command with above data.
2. System deletes old cache data.
3. System encodes image feed.
4. System timestamps the new cache.
5. System saves new cache data.
6. System delivers success message.
#### Deleting error course (sad path):
1. System delivers error.
#### Saving error course (sad path):
1. System delivers error.
---
## Flowchart
![Feed Loading Feature](feed_flowchart.png)

## Architecture
![Feed Loading Feature](feed_architecture.png)
## Model Specs
### Feed Image
| Property      | Type                |
|---------------|---------------------|
| `id`          | `UUID`              |
| `description` | `String` (optional) |
| `location`    | `String` (optional) |
| `url`	        | `URL`               |
### Payload contract
```
GET *url* (TBD)