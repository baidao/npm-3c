<html>
<head>
  <title></title>
  <link rel="stylesheet" type="text/css" href="http://cdn.staticfile.org/mocha/1.20.1/mocha.css">
  <link rel="stylesheet" type="text/css" href="http://cdn.staticfile.org/pure/0.5.0/tables-min.css">
</head>
<body ng-app="check">
  <script type="text/javascript" src="https://rawgithub.com/alexeykuzmin/jsonpointer.js/master/src/jsonpointer.js"></script>
  <script type="text/javascript" src="https://rawgithub.com/geraintluff/tv4/master/tv4.js"></script>
  <script type="text/javascript" src="http://cdn.staticfile.org/chai/1.9.1/chai.min.js"></script>
  <script type="text/javascript" src="http://cdn.staticfile.org/angular.js/1.3.0-beta.13/angular.min.js"></script>
  <script type="text/javascript">
  angular.module('check',[]).run(['$rootScope', '$http', function($rootScope, $http) {
    $rootScope.schemas = {};
    $http({method: 'GET', url: '/schemas'}).
      success(function(data) {
        $rootScope.schemas = data;
        console.log($rootScope.schemas);
      });
    }
  ]);
  </script>
</body>
</html>