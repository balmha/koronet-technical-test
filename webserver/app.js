//write a node.js server that listens on port 3000 and serves the following html file. The server should only serve this file for the exact request url './index.html'. All other request urls should return a 404 error.
// The node.js server  should connect to a redis database which will be included in the docker-compose setup

var http = require('http');
var fs = require('fs');
var path = require('path');

http.createServer(function (req, res) {
    if (req.url === './index.html') {
        fs.readFile(path.join(__dirname, 'index.html'), function (err, data) {
        if (err) {
            res.writeHead(500);
            res.end('Error loading index.html');
        } else {
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end(data);
        }
        });
    } else {
        res.writeHead(404);
        res.end('Not Found');
    }
    }
).listen(3000);

console.log('Server running at http://localhost:3000/');

// Create a connection to a local Redis instance
var redis = require('redis');
var client = redis.createClient(6379, 'redis');
// Set redis credentials
client.auth('password');
// Set a value
client.set('my test key', 'my test value', redis.print);
// Retrieve a value
client.get('my test key', function (error, result) {
    if (error) {
        console.log(error);
        throw error;
    }
    console.log('GET result ->' + result);
});
// Disconnect from the Redis client
client.quit();
