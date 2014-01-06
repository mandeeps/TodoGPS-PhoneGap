"use strict"

window.addEventListener 'load', ->
  FastClick.attach document.body
,false

main = angular.module('TodoGPS',[])

main.controller 'mainController', ($scope, $http) ->
  navigator.geolocation.watchPosition (position) ->
    $scope.loc = position.coords
    console.log position.coords

  $scope.formData = {}

  $http.get('https://todogps.herokuapp.com/api/todos')
  .success (data) ->
    $scope.todos = data
  .error (data) ->
    console.log data

  $scope.createTodo = ->
    $http.post('https://todogps.herokuapp.com/api/todos', $scope.formData)
    .success (data) ->
      $scope.formData = {}
      $scope.todos = data

    .error (data) ->
      console.log data

  $scope.deleteTodo = (id) ->
    $http.delete('https://todogps.herokuapp.com/api/todos/' + id)
    .success (data) ->
      $scope.todos = data