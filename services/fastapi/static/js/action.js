
// const userAction = async () => {
//   const response = await fetch('https://le5erao8i3.execute-api.us-east-1.amazonaws.com/test/dyanmodbmanager', {
//     method: 'POST',
//     body: {
//       'httpMethod': 'POST',
//       'queryStringParameters': {
//         'TableName': 'reaney-resume-website'
//       }
//     }, // string or object
//     headers: {
//       'Content-Type': 'application/json'
//     }
//   });
//   const myJson = await response; //extract JSON from the http response
//   // do something with myJson
//   console.log(myJson.body)
// }

// //const count = "afaweawef";
// userAction()

data = {
  "httpMethod": 'POST',
  'queryStringParameters': {
    'TableName': 'reaney-resume-website'
  }
}

const request = fetch('https://le5erao8i3.execute-api.us-east-1.amazonaws.com/test/dyanmodbmanager', {
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'm1GL1eXff98vf51VQ9AJ94TKmdWTwSfT7xbnHgMp'
    }
  })
  .then((response) => response.json())
  //.then((data) => console.log(JSON.parse(data.body).Items['0'].number['N']))
  .then((data) => JSON.parse(data.body).Items['0'].number['N'])
  .then((data) => {document.getElementById("count").innerHTML = data})
  

// async function foo() {
//   let obj;
//   const result = await fetch('https://le5erao8i3.execute-api.us-east-1.amazonaws.com/test/dyanmodbmanager', {
//     method: 'POST',
//     body: JSON.stringify(data),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'm1GL1eXff98vf51VQ9AJ94TKmdWTwSfT7xbnHgMp'
//     }
//   })

//   obj = await result.json();

//   x = await JSON.parse(obj.body).Items['0'].number['N'];

//   console.log(x)
//   //document.getElementById("count").innerHTML = await await JSON.parse(result.json().body).Items['0'].number['N'];
// }

// foo();