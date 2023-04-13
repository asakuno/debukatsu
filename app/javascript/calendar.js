import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

const fetchGroups = () => {
  return new Promise(async (resolve, reject) => {
      try {
          const response = await fetch("/api/mine/groups/")
          const data = await response.json()
          resolve(data)
      } catch {
          const message = "エラーが発生しました。"
          alert(message)
          reject(message)
      }
  })
}

document.addEventListener('DOMContentLoaded',  async () => {
  const calendarEl = document.getElementById('calendar');
  if (!calendarEl) return;

  const { groups } = await fetchGroups()
  const calendar = new Calendar(calendarEl, {
      plugins: [ interactionPlugin, dayGridPlugin],
      headerToolbar: {
          right: 'prev,next today',
          center: 'title',
          left: false
      },
      initialDate: new Date(),
      dayMaxEvents: true,
      locale: 'ja',
      events: groups
  });
  calendar.render();
});