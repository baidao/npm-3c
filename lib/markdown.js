var create, fs, handlebars, path;
fs = require("fs");
path = require("path");
handlebars = require("handlebars");
handlebars.registerHelper('json', function(obj) {
  return JSON.stringify(obj, null, '\t');
});
create = function(config) {
  var docPath, files, tmpl, tmplPath;
  files = config.files || [];
  docPath = path.resolve(process.cwd(), config.doc || './doc/api.md');
  tmplPath = path.resolve(__dirname, './templates/md.tpl');
  tmpl = fs.readFileSync(tmplPath, "utf-8");
  try {
    if (fs.existsSync(docPath)) {
      fs.unlinkSync(docPath);
    }
  } catch (err) {
    console.log(err);
  }
  files.forEach(function(file) {
    var doc, filePath, schemas;
    filePath = path.resolve(process.cwd(), "./schema/" + file);
    schemas = require(filePath);
    try {
      doc = handlebars.compile(tmpl)({
        schemas: schemas
      });
      return fs.appendFileSync(docPath, doc);
    } catch (err) {
      return console.error(err);
    }
  });
  return console.info("############# \n api markdown generated at " + docPath + " ...  \n#############");
};
module.exports = {
  create: create
};