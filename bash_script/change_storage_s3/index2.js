exports.handler = function(event, context, callback) {
    const execFile = require('child_process').execFile;
    execFile('./script.sh', (error, stdout, stderr) => {
      if (error) {
        callback(error);
      }
      callback(null, stdout);
    });
  }