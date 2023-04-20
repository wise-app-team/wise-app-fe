const withMT = require("@material-tailwind/html/utils/withMT");

module.exports = withMT({
  content: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
});