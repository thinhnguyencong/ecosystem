
let sharedFolders = [
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
    parent: 35,
    ancestors: [33,34,35],
    shared: [
      "user2"
    ]
  },
  {
    id: 37,
    name: "name 37",
    parent: 36,
    ancestors: [33,34,35,36],
    shared: [
      "user2"
    ]
  },
]
let id =     [2,3,7,36,37]
let parent = [1,2,6,35,36]
let ancestors = [[1], [1,2], [5,6], [33,34,35], [33,34,35,36]] 
let result =[]
for (let index = 0; index < ancestors.length; index++) {
  const element = ancestors[index];
  const contains = element.some(e => {
    return id.includes(e);
  });
  if(!contains) {
    result.push(id[index])
  }
}

console.log(result);