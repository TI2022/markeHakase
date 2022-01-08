//インストールしたファイルたちを呼び出します。
import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import monthGridPlugin from '@fullcalendar/daygrid';
import googleCalendarApi from '@fullcalendar/google-calendar';
import timeGridPlugin from '@fullcalendar/timegrid';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作っていきます。
document.addEventListener("turbolinks:load", function() {
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
      center: 'title',
      end: 'today prev,next'
    },
    titleFormat: function(obj) {
      return obj.date.year+"年"+(obj.date.month+1)+"月";
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
    allDayText: '終日',
    height: "auto",
    events: "/reservations/confirm_reservation.json",
    eventClick: function(info){
      // 保留
    },
    eventDidMount: function (info) {
      if (info.event._def.title=='仮予約') {
        info.el.style.background='gray' ;
      }else{
        info.el.style.background='green' ;
      }
      if (info.event._def.title=='施術完了') {
        info.el.style.background='blue' ;
      }
    }
  });
  //カレンダー表示
  calendar.render();
});
