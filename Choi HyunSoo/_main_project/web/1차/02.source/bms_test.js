// var mysql = require('mysql');
// var connection = mysql.createConnection({
//     host:'localhost'
// 	,user:'root'
//     ,password:'wkrtkf'
//     ,database:'_test1'
// });

// connection.connect();

// connection.query('select * from _test1', function(error, results, fields){
//     if (error) {
//         console.log(error);
//     }
//     console.log(results)
// });

// connection.end();

var req = new XMLHttpRequest();
req.open("GET", "./bms_test.json");
req.onreadystatechange =  function(){
    if( this.readyState == 4 ){
        var data = JSON.parse(this.response);
    }
    console.log(data);
}

req.send();