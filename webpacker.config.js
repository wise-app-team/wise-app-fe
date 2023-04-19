const PurgecssPlugin = require('purgecss-webpack-plugin');
const glob = require('glob');
const path = require('path');
const purgecssConfig = require('./purgecss.config');

module.exports = {
  // ...
  plugins: [
    // ...
    new PurgecssPlugin({
      paths: glob.sync(path.join(__dirname, 'app/**/*'), { nodir: true }),
      ...purgecssConfig,
    }),
  ],
};
