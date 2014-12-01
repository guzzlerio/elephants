var http = require('http');

var hostname = '0.0.0.0';
var port = 3000;

var server = http.createServer(function(req, res){
   res.writeHead(200, {
        'content-type':'text/plain'
   }); 
   res.end('Hello world\n');
});

server.listen(port, hostname, function(){
    console.log('listening on ', hostname, port);
});
