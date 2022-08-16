exports.handler = function(event, context, callback) {
    const execFile = require('child_process').execFile;
    execFile('./main.sh', (error, stdout, stderr) => {
      if (error) {
        callback(error);
      }
      callback(null, stdout);
    });
  }