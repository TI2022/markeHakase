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
require("../src/quill.js")

//インストールしたファイルたちを呼び出します。
import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid';
import googleCalendarApi from '@fullcalendar/google-calendar';
import timeGridPlugin from '@fullcalendar/timegrid';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作っていきます。
  document.addEventListener("turbolinks:load", () => {
    if (location.pathname === '/reservations') {
      let calendarEl = document.getElementById('calendar');

      //カレンダーの中身を設定(月表示とか、クリックアクション起こしたいとか、googleCalendar使うととか)
      let calendar = new Calendar(calendarEl, {
        plugins: [ monthGridPlugin, interactionPlugin, googleCalendarApi, timeGridPlugin ],

        initialView: 'timeGridWeek',
        firstDay: (new Date()).getDay(),
        validRange: {
          start: new Date()
        },
        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        headerToolbar: {
          start: '',
          left: 'title',
          end: 'today prev,next'
        },
        footerToolbar: {
          right: "prev,next"
        },
        views: {
          timeGridWeek: {
            titleFormat: function (date) {
              const startMonth = date.start.month + 1;
              const endMonth = date.end.month + 1;
        
              // 1週間のうちに月をまたぐかどうかの分岐処理
              if (startMonth === endMonth) {
                return startMonth + '月';
              } else {
                return startMonth + '月～' + endMonth + '月'; 
              }
            },
            dayHeaderFormat: function (date) {
              const day = date.date.day;
              const weekNum = date.date.marker.getDay();
              const week = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)'][weekNum];
              return day + ' ' + week;
            }
          }
        },
        selectable: true,
        slotMinTime: '10:00:00',
        slotMaxTime: '20:00:00',
        slotDuration: '00:10:00',
        slotLabelInterval: '01:00:00',
        slotLabelFormat: {
          hour: 'numeric',
          minute: '2-digit',
          omitZeroMinute: false,
          meridiem: 'short'
        },
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
          today: '今日'
        },
        nowIndicator: true,
        allDayText: 'スタッフ人数',
        height: "auto",
        events: "/reservations.json",
        eventDidMount: function (info) {
          if (info.event._def.title=='予約確定') {
            info.el.style.background='green' ;
          }
          if (info.event._def.title=='仮予約') {
            info.el.style.background='gray' ;
          }
          if (info.event._def.title=='×') {
            info.el.style.background='darkgray' ;
          }
          if (info.event._def.title=='施術完了') {
            info.el.style.background='blue' ;
          }
          if (info.event._def.title=='1人') {
            info.el.style.background='darkgray' ;
          }
          if (info.event._def.title=='2人') {
            info.el.style.background='darkgray' ;
          }
          if (info.event._def.title=='3人') {
            info.el.style.background='darkgray' ;
          }
        }
      });
      //カレンダー表示
      calendar.render();
    } else {
      // なにもしない
    }
  });

// 写真
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

Rails.start()
Turbolinks.start()
ActiveStorage.start()
