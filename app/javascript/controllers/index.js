// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NewfoodsController from "./newfoods_controller"
application.register("newfoods", NewfoodsController)

import NewgroupsController from "./newgroups_controller"
application.register("newgroups", NewgroupsController)

import SignupController from "./signup_controller"
application.register("signup", SignupController)
