<html>
<head>
  <title></title>
  <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body ng-app="check" style="padding: 10px;">
  <div ng-repeat="(filename, file) in files">
    <div ng-repeat="schema in file" ng-init="initForm(schema)" ng-controller="formCtrl">
      <h3>{{schema.meta.title}}</h3>
      <form class="pure-form">
        <div class="form-group">
          <input class="form-control input-lg" type="text" placeholder="uri" ng-model="model.uri">
        </div>
        <div class="form-group" ng-repeat="(key, val) in model.params">
          <input class="form-control input-lg" type="text" placeholder="{{key}}" ng-model="model.params[key]">
        </div>
        <div class="form-group">
          <button type="button" class="btn btn-danger btn-lg btn-block" ng-click="sendRequest()">
            Check {{model.method}}
          </button>
        </div>
      </form>
      <div ng-show="checked">
        <div class="alert alert-{{request.status}}" role="alert" ng-bind="request.info"></div>
        <div class="alert alert-{{validate.status}}" role="alert" ng-bind="validate.info"></div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="http://cdn.staticfile.org/angular.js/1.3.0-beta.13/angular.min.js"></script>
  <script type="text/javascript" src="https://rawgithub.com/alexeykuzmin/jsonpointer.js/master/src/jsonpointer.js"></script>
  <script type="text/javascript" src="https://rawgithub.com/geraintluff/tv4/master/tv4.js"></script>
  <script type="text/javascript" src="http://cdn.staticfile.org/chai/1.9.1/chai.min.js"></script>
  <script type="text/javascript" src="https://rawgithub.com/meltuhamy/chai-json-schema/master/index.js"></script>
  <script type="text/javascript">
  angular.module('check',[]).run(['$rootScope', '$http', function($rootScope, $http) {
    $rootScope.files = {};
    $http({method: 'GET', url: '/schemas'}).
      success(function(data) {
        $rootScope.files = data;
        console.log($rootScope.files);
      });
    }
  ]);
  angular.module('check').controller('formCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.model = {}
    $scope.initForm = function(schema) {
      $scope.successSchema = schema.success;
      $scope.errorSchema = schema.error;
      $scope.model.uri = schema.meta.host + schema.meta.uri;
      $scope.model.method = schema.meta.method;
      $scope.model.params = {}
      for(key in schema.params.properties) {
        $scope.model.params[key] = schema.params.properties[key].default
      }
    }

    $scope.sendRequest = function() {
      var config = {
        method: $scope.model.method,
        url: $scope.model.uri
      };
      if ($scope.model.method.toLowerCase() === 'get')
        config.params = $scope.model.params
      else
        config.data = $scope.model.params
      $http(config).success(function(data, status) {
        $scope.checked = true;
        // 成功
        $scope.request = {
          status: 'success',
          info: '请求成功!'
        }
        // 验证
        try {
          chai.assert.jsonSchema(data, $scope.successSchema);
          $scope.validate = {
            status: 'success',
            info: '验证成功!'
          }
        } catch(err) {
          console.log(err);
          $scope.validate = {
            status: 'danger',
            info: '验证失败! ' + err.message
          }
        }
      }).error(function(data, status) {
        $scope.checked = true;
        $scope.request = {
          status: 'danger',
          info: '请求失败!'
        }
        // 失败
        $scope.validateStatus = 'error'
        // 验证
        try {
          chai.assert.jsonSchema(data, $scope.errorSchema);
          $scope.validate = {
            status: 'success',
            info: '验证成功!'
          }
        } catch(err) {
          console.log(err);
          $scope.validate = {
            status: 'danger',
            info: '验证失败! ' + err.message
          }
        }
      });
    }
  }]);
  </script>
</body>
</html>