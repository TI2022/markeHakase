import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import jQuery from "jquery"
// jQueryを読み込ませてからbootstrapを読み込ませる。
window.$ = window.JQuery = jQuery;

import "channels"
import 'bootstrap'
import '../src/application.scss'

require("../src/min.js")
require("../src/common.js")

// 写真
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

Rails.start()
Turbolinks.start()
ActiveStorage.start()