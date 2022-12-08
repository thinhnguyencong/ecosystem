let sharedFolders = [
  {
    id: 1,
    name: 'name 1',
    parent: null,
    ancestors: [],
    shared: [
      "user1", "user2"
    ]
  },
  {
    id: 2,
    name: 'name 2',
    parent: 1,
    ancestors: [1],
    shared: [
      "user1", "user2"
    ]
  },
  {
    id: 3,
    name: 'name 3',
    parent: 2,
    ancestors: [1,2],
    shared: [
      "user1", "user2"
    ]
  },
  {
    id: 7,
    name: "name 7",
    parent: 6,
    ancestors: [5,6],
    shared: [
      "user2"
    ]
  },
  {
    id: 36,
    name: "name 36",
    parent: 25,
    ancestors: [23,24,25],
    shared: [
      "user2"
    ]
  },
  {
    id: 37,
    name: "name 37",
    parent: 36,
    ancestors: [23,24,25,36],
    shared: [
      "user2"
    ]
  },
]
id = [2,3,7,36,37]
parent = [1,2,6,25,36]
ancestors = [[1], [1,2], [5,6], [23,24,25], [23,24,25,36]] 
// => [1,5,23]
// => [[2,3,..], [6,7,..], [24,25,36,37,..]]
result = [7,36]