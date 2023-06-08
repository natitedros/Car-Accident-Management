const jwt = require('jsonwebtoken');

function validateToken(req, res, next) {
  let token = undefined;
  if (req.headers.authorization){
    token = req.headers.authorization.split(' ')[1];
  }

  if (!token) {
    return res.status(401).json({ message: 'No token provided.' });
  }

  jwt.verify(token, 'natitedros secret', (err, decoded) => {

    if (err) {
        // const tokenExpiration = decoded.exp;
        // const currentTimestamp = Math.floor(Date.now() / 1000);
        // if (tokenExpiration < currentTimestamp) {
        //     return res.status(401).json({ message: 'Token has expired.' });
        // }
        return res.status(403).json({ message: 'Failed to authenticate token.' });
    }
    
    // Token is valid, you can optionally attach the decoded token to the request for later use
    req.user = decoded;

    next();
  });
}

module.exports = { validateToken }
