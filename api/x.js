let input = [
    {
      _id: "63a163e678ae1178af4fd492",
      name: "258147",
      type: "normal",
      parent: "63a004e8413df1816c2274e4",
      ancestors: [
        "63a004e8413df1816c2274e4"
      ],
      files: [],
      owner: "63a004e8413df1816c2274de",
      shared: [],
      createdAt: "2022-12-20T07:27:34.906Z",
      updatedAt: "2022-12-20T07:27:34.906Z",
      __v: 0
    },
    {
      _id: "63a1640378ae1178af4fd50b",
      name: "Folder 1",
      type: "normal",
      parent: "63a163e678ae1178af4fd492",
      ancestors: [
        "63a004e8413df1816c2274e4",
        "63a163e678ae1178af4fd492"
      ],
      files: [],
      owner: "63a004e8413df1816c2274de",
      shared: [],
      createdAt: "2022-12-20T07:28:03.115Z",
      updatedAt: "2022-12-20T07:28:03.115Z",
      __v: 0
    },
    {
      _id: "63a1640a78ae1178af4fd540",
      name: "Folder 2",
      type: "normal",
      parent: "63a163e678ae1178af4fd492",
      ancestors: [
        "63a004e8413df1816c2274e4",
        "63a163e678ae1178af4fd492"
      ],
      files: [],
      owner: "63a004e8413df1816c2274de",
      shared: [],
      createdAt: "2022-12-20T07:28:10.751Z",
      updatedAt: "2022-12-20T07:28:10.751Z",
      __v: 0
    },
    {
      _id: "63a1641e78ae1178af4fd5f1",
      name: "Children 1",
      type: "normal",
      parent: "63a1640378ae1178af4fd50b",
      ancestors: [
        "63a004e8413df1816c2274e4",
        "63a163e678ae1178af4fd492",
        "63a1640378ae1178af4fd50b"
      ],
      files: [],
      owner: "63a004e8413df1816c2274de",
      shared: [],
      createdAt: "2022-12-20T07:28:30.979Z",
      updatedAt: "2022-12-20T07:28:30.979Z",
      __v: 0
    },
    {
      _id: "63a1651778ae1178af4fd831",
      name: "Children 2",
      type: "normal",
      parent: "63a1640a78ae1178af4fd540",
      ancestors: [
        "63a004e8413df1816c2274e4",
        "63a163e678ae1178af4fd492",
        "63a1640a78ae1178af4fd540"
      ],
      files: [],
      owner: "63a004e8413df1816c2274de",
      shared: [],
      createdAt: "2022-12-20T07:32:39.930Z",
      updatedAt: "2022-12-20T07:32:39.930Z",
      __v: 0
    }
  ]

  let output = [
    {
        id: "63a163e678ae1178af4fd492",
        name: "258147",
        children: [
            {
                id: "63a1640378ae1178af4fd50b",
                name: "Folder 1",
                children: [
                    {
                        id: "63a1641e78ae1178af4fd5f1",
                        name: "Children 1",
                        children: []
                    }
                ]
            },
            {
                id: "63a1640a78ae1178af4fd540",
                name: "Folder 2",
                children: [
                    {
                        id: "63a1651778ae1178af4fd831",
                        name: "Children 2",
                        children: []
                    }
                ]
            }
        ]
    }
  ]
  
lo