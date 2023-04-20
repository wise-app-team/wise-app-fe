module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  css: ['./app/javascript/**/*.css'],
  whitelist: ['active'],
  defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || [],
};
